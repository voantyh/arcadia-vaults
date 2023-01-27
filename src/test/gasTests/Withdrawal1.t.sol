/**
 * Created by Arcadia Finance
 * https://www.arcadia.finance
 *
 * SPDX-License-Identifier: BUSL-1.1
 */
pragma solidity >0.8.10;

import "../fixtures/GastTestFixture.f.sol";

contract gasWithdrawal1_1ERC20 is GasTestFixture {
    using stdStorage for StdStorage;

    bytes3 public emptyBytes3;

    //this is a before
    constructor() GasTestFixture() {}

    //this is a before each
    function setUp() public override {
        super.setUp();

        vm.startPrank(vaultOwner);
        s_assetAddresses = new address[](1);
        s_assetAddresses[0] = address(eth);

        s_assetIds = new uint256[](1);
        s_assetIds[0] = 0;

        s_assetAmounts = new uint256[](1);
        s_assetAmounts[0] = 10 ** Constants.ethDecimals;

        s_assetTypes = new uint256[](1);
        s_assetTypes[0] = 0;

        proxy.deposit(s_assetAddresses, s_assetIds, s_assetAmounts, s_assetTypes);
        vm.stopPrank();
    }

    function testGetValue_1_ERC20() public view {
        proxy.getVaultValue(0x0000000000000000000000000000000000000000);
    }

    function testGetRemainingValue_1_ERC20() public view {
        proxy.getFreeMargin();
    }

    function testBorrow() public {
        vm.prank(vaultOwner);
        pool.borrow(1, address(proxy), vaultOwner, emptyBytes3);
    }

    function testGenerateAssetData() public view {
        proxy.generateAssetData();
    }

    function testWithdrawal_1_ERC20_partly() public {
        address[] memory assetAddresses;
        uint256[] memory assetIds;
        uint256[] memory assetAmounts;
        uint256[] memory assetTypes;

        assetAddresses = new address[](1);
        assetAddresses[0] = address(eth);

        assetIds = new uint256[](1);
        assetIds[0] = 0;

        assetAmounts = new uint256[](1);
        assetAmounts[0] = 10 ** (Constants.ethDecimals - 1);

        assetTypes = new uint256[](1);
        assetTypes[0] = 0;

        vm.startPrank(vaultOwner);
        proxy.withdraw(assetAddresses, assetIds, assetAmounts, assetTypes);
    }

    function testWithdrawal_1_ERC20_all() public {
        address[] memory assetAddresses;
        uint256[] memory assetIds;
        uint256[] memory assetAmounts;
        uint256[] memory assetTypes;

        assetAddresses = new address[](1);
        assetAddresses[0] = address(eth);

        assetIds = new uint256[](1);
        assetIds[0] = 0;

        assetAmounts = new uint256[](1);
        assetAmounts[0] = 10 ** Constants.ethDecimals;

        assetTypes = new uint256[](1);
        assetTypes[0] = 0;

        vm.startPrank(vaultOwner);
        proxy.withdraw(assetAddresses, assetIds, assetAmounts, assetTypes);
    }
}
