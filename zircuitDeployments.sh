# To use this script, you need to fill in the following information in your .env file:
# ZIRCUIT_GARFIELD_PRIVATE_KEY, ZIRCUIT_PRIVATE_KEY

# Deploy the Mock ERC20 token
forge create contracts/Mocks/ERC20Mock.sol:ERC20Mock --broadcast --rpc-url $ZIRCUIT_GARFIELD_RPC --private-key $ZIRCUIT_GARFIELD_PRIVATE_KEY

# Output:
# Deployed to: 0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F
# Transaction hash: 0xb48fc28a8a8628a6efe012c75f9f578754788f56dc5164c7f2cd876c7650c43a

#==============================================

# Verify the contract
forge verify-contract --verifier sourcify 0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F contracts/Mocks/ERC20Mock.sol:ERC20Mock --root . --chain-id $ZIRCUIT_GARFIELD_CHAIN_ID

#==============================================

# Deploy the Tornado Cash instances
forge script foundry_scripts/Deploy.s.sol \
--sig "run(address[],uint256[])" \
"[0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F,0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F,0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F]" \
"[1000000000000000000,10000000000000000000,100000000000000000000]" \
--broadcast \
--rpc-url $ZIRCUIT_GARFIELD_RPC \
--private-key $ZIRCUIT_GARFIELD_PRIVATE_KEY

# Output
# == Logs ==
#   -> Verifier deployed at 0x685Bc3aBDbAAa9E87E0CFe4B772e266c88Ae8e53
#   -> Hasher deployed at 0xA92d7B71d470B4972F0A42d5f4d21e0F851D9d2e
#   -> Tornado 1 * 0.1 ETH deployed at: 0x5b8f233111381BaEd398F2Ce812e5Fa9acF1e9fa
#   -> Tornado 10 * 0.1 ETH deployed at: 0xD4f694e4B55C026F9fB98f0cb0faB65Ed42c669f
#   -> Tornado 100 * 0.1 ETH deployed at: 0xFf6bDc1EE54301C0BD2393f03d24f7C23B5B265a
#   -> Tornado 1000 * 0.1 ETH deployed at: 0xb1dAbC876Cc8e5D599F1362c72Cd621B66a5c7f2
#   -> Tornado with denomination of 1000000000000000000 for ERC20 address 0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F deployed at 0x4E457c172144D4a1f08F61F54A37dd819a6ba28E
#   -> Tornado with denomination of 10000000000000000000 for ERC20 address 0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F deployed at 0x1D0d17614870096Da33DF25cb185A840065815D6
#   -> Tornado with denomination of 100000000000000000000 for ERC20 address 0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F deployed at 0xfbC71A6Ba7DdF32bD2C53ec0A9bd5df4e0d828Ac

#==============================================

Deploy the Tornado Cash instances (for ETH, ZRC, USDT and USDC)
forge script foundry_scripts/Deploy.s.sol \
--sig "run(address[],uint256[])" \
"[0xfd418e42783382E86Ae91e445406600Ba144D162,0xfd418e42783382E86Ae91e445406600Ba144D162,0xfd418e42783382E86Ae91e445406600Ba144D162,0x46dDa6a5a559d861c06EC9a95Fb395f5C3Db0742,0x46dDa6a5a559d861c06EC9a95Fb395f5C3Db0742,0x46dDa6a5a559d861c06EC9a95Fb395f5C3Db0742,0x3b952c8C9C44e8Fe201e2b26F6B2200203214cfF,0x3b952c8C9C44e8Fe201e2b26F6B2200203214cfF,0x3b952c8C9C44e8Fe201e2b26F6B2200203214cfF]" \
"[1000000000000000000,10000000000000000000,100000000000000000000,1000000,10000000,100000000,1000000,10000000,100000000]" \
--broadcast \
--rpc-url $ZIRCUIT_RPC \
--private-key $ZIRCUIT_PRIVATE_KEY

# Output
# == Logs ==
#   -> Verifier deployed at 0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F
#   -> Hasher deployed at 0x685Bc3aBDbAAa9E87E0CFe4B772e266c88Ae8e53
#   -> Tornado 1 * 0.1 ETH deployed at: 0xA92d7B71d470B4972F0A42d5f4d21e0F851D9d2e
#   -> Tornado 10 * 0.1 ETH deployed at: 0x5b8f233111381BaEd398F2Ce812e5Fa9acF1e9fa
#   -> Tornado 100 * 0.1 ETH deployed at: 0xD4f694e4B55C026F9fB98f0cb0faB65Ed42c669f
#   -> Tornado 1000 * 0.1 ETH deployed at: 0xFf6bDc1EE54301C0BD2393f03d24f7C23B5B265a
#   -> Tornado with denomination of 1000000000000000000 for ERC20 address 0xfd418e42783382E86Ae91e445406600Ba144D162 (ZRC) deployed at 0xb1dAbC876Cc8e5D599F1362c72Cd621B66a5c7f2
#   -> Tornado with denomination of 10000000000000000000 for ERC20 address 0xfd418e42783382E86Ae91e445406600Ba144D162 (ZRC) deployed at 0x4E457c172144D4a1f08F61F54A37dd819a6ba28E
#   -> Tornado with denomination of 100000000000000000000 for ERC20 address 0xfd418e42783382E86Ae91e445406600Ba144D162 (ZRC)deployed at 0x1D0d17614870096Da33DF25cb185A840065815D6
#   -> Tornado with denomination of 1000000 for ERC20 address 0x46dDa6a5a559d861c06EC9a95Fb395f5C3Db0742 (USDT) deployed at 0xfbC71A6Ba7DdF32bD2C53ec0A9bd5df4e0d828Ac
#   -> Tornado with denomination of 10000000 for ERC20 address 0x46dDa6a5a559d861c06EC9a95Fb395f5C3Db0742 (USDT) deployed at 0x62DfcB3f4AEde1fA193138fd67f429878081b2e3
#   -> Tornado with denomination of 100000000 for ERC20 address 0x46dDa6a5a559d861c06EC9a95Fb395f5C3Db0742 (USDT) deployed at 0xA11908E92FE3b073A89136b05D0D6C9a5426CC44
#   -> Tornado with denomination of 1000000 for ERC20 address 0x3b952c8C9C44e8Fe201e2b26F6B2200203214cfF (USDC) deployed at 0xaDe2910F16c1f2cFe963d84d248d85748288D6Ca
#   -> Tornado with denomination of 10000000 for ERC20 address 0x3b952c8C9C44e8Fe201e2b26F6B2200203214cfF (USDC) deployed at 0x41d1436B0F1737F3219c5D040508C98D56bC464a
#   -> Tornado with denomination of 100000000 for ERC20 address 0x3b952c8C9C44e8Fe201e2b26F6B2200203214cfF (USDC) deployed at 0x2522d533BcB8952fbAa7B7181699c0Da936EEc10

#==============================================

# Verify the contracts

# Verifier
forge verify-contract --verifier sourcify 0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F contracts/Verifier.sol:Verifier --root . --chain-id $ZIRCUIT_CHAIN_ID

# ETH Tornado for the different denominations
forge verify-contract \
--verifier sourcify \
0xA92d7B71d470B4972F0A42d5f4d21e0F851D9d2e \
contracts/ETHTornado.sol:ETHTornado \
--root . \
--chain-id $ZIRCUIT_CHAIN_ID \
--constructor-args $(cast abi-encode "constructor(address,address,uint256,uint32)" "0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F" "0x685Bc3aBDbAAa9E87E0CFe4B772e266c88Ae8e53" 100000000000000000 20)

forge verify-contract \
--verifier sourcify \
0x5b8f233111381BaEd398F2Ce812e5Fa9acF1e9fa \
contracts/ETHTornado.sol:ETHTornado \
--root . \
--chain-id $ZIRCUIT_CHAIN_ID \
--constructor-args $(cast abi-encode "constructor(address,address,uint256,uint32)" "0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F" "0x685Bc3aBDbAAa9E87E0CFe4B772e266c88Ae8e53" 1000000000000000000 20)

forge verify-contract \
--verifier sourcify \
0xD4f694e4B55C026F9fB98f0cb0faB65Ed42c669f \
contracts/ETHTornado.sol:ETHTornado \
--root . \
--chain-id $ZIRCUIT_CHAIN_ID \
--constructor-args $(cast abi-encode "constructor(address,address,uint256,uint32)" "0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F" "0x685Bc3aBDbAAa9E87E0CFe4B772e266c88Ae8e53" 10000000000000000000 20)

forge verify-contract \
--verifier sourcify \
0xFf6bDc1EE54301C0BD2393f03d24f7C23B5B265a \
contracts/ETHTornado.sol:ETHTornado \
--root . \
--chain-id $ZIRCUIT_CHAIN_ID \
--constructor-args $(cast abi-encode "constructor(address,address,uint256,uint32)" "0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F" "0x685Bc3aBDbAAa9E87E0CFe4B772e266c88Ae8e53" 100000000000000000000 20)

# ERC20 Tornado for the different denominations of ZRC
forge verify-contract \
--verifier sourcify \
0xb1dAbC876Cc8e5D599F1362c72Cd621B66a5c7f2 \
contracts/ERC20Tornado.sol:ERC20Tornado \
--root . \
--chain-id $ZIRCUIT_CHAIN_ID \
--constructor-args $(cast abi-encode "constructor(address,address,uint256,uint32,address)" "0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F" "0x685Bc3aBDbAAa9E87E0CFe4B772e266c88Ae8e53" 1000000000000000000 20 "0xfd418e42783382E86Ae91e445406600Ba144D162")

forge verify-contract \
--verifier sourcify \
0x4E457c172144D4a1f08F61F54A37dd819a6ba28E \
contracts/ERC20Tornado.sol:ERC20Tornado \
--root . \
--chain-id $ZIRCUIT_CHAIN_ID \
--constructor-args $(cast abi-encode "constructor(address,address,uint256,uint32,address)" "0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F" "0x685Bc3aBDbAAa9E87E0CFe4B772e266c88Ae8e53" 10000000000000000000 20 "0xfd418e42783382E86Ae91e445406600Ba144D162")

forge verify-contract \
--verifier sourcify \
0x1D0d17614870096Da33DF25cb185A840065815D6 \
contracts/ERC20Tornado.sol:ERC20Tornado \
--root . \
--chain-id $ZIRCUIT_CHAIN_ID \
--constructor-args $(cast abi-encode "constructor(address,address,uint256,uint32,address)" "0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F" "0x685Bc3aBDbAAa9E87E0CFe4B772e266c88Ae8e53" 1000000000000000000000 20 "0xfd418e42783382E86Ae91e445406600Ba144D162")

# ERC20 Tornado for the different denominations of USDT
forge verify-contract \
--verifier sourcify \
0xfbC71A6Ba7DdF32bD2C53ec0A9bd5df4e0d828Ac \
contracts/ERC20Tornado.sol:ERC20Tornado \
--root . \
--chain-id $ZIRCUIT_CHAIN_ID \
--constructor-args $(cast abi-encode "constructor(address,address,uint256,uint32,address)" "0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F" "0x685Bc3aBDbAAa9E87E0CFe4B772e266c88Ae8e53" 1000000 20 "0x46dDa6a5a559d861c06EC9a95Fb395f5C3Db0742")

forge verify-contract \
--verifier sourcify \
0x62DfcB3f4AEde1fA193138fd67f429878081b2e3 \
contracts/ERC20Tornado.sol:ERC20Tornado \
--root . \
--chain-id $ZIRCUIT_CHAIN_ID \
--constructor-args $(cast abi-encode "constructor(address,address,uint256,uint32,address)" "0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F" "0x685Bc3aBDbAAa9E87E0CFe4B772e266c88Ae8e53" 10000000 20 "0x46dDa6a5a559d861c06EC9a95Fb395f5C3Db0742")

forge verify-contract \
--verifier sourcify \
0xA11908E92FE3b073A89136b05D0D6C9a5426CC44 \
contracts/ERC20Tornado.sol:ERC20Tornado \
--root . \
--chain-id $ZIRCUIT_CHAIN_ID \
--constructor-args $(cast abi-encode "constructor(address,address,uint256,uint32,address)" "0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F" "0x685Bc3aBDbAAa9E87E0CFe4B772e266c88Ae8e53" 100000000 20 "0x46dDa6a5a559d861c06EC9a95Fb395f5C3Db0742")

# ERC20 Tornado for the different denominations of USDC
forge verify-contract \
--verifier sourcify \
0xaDe2910F16c1f2cFe963d84d248d85748288D6Ca \
contracts/ERC20Tornado.sol:ERC20Tornado \
--root . \
--chain-id $ZIRCUIT_CHAIN_ID \
--constructor-args $(cast abi-encode "constructor(address,address,uint256,uint32,address)" "0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F" "0x685Bc3aBDbAAa9E87E0CFe4B772e266c88Ae8e53" 1000000 20 "0x3b952c8C9C44e8Fe201e2b26F6B2200203214cfF")

forge verify-contract \
--verifier sourcify \
0x41d1436B0F1737F3219c5D040508C98D56bC464a \
contracts/ERC20Tornado.sol:ERC20Tornado \
--root . \
--chain-id $ZIRCUIT_CHAIN_ID \
--constructor-args $(cast abi-encode "constructor(address,address,uint256,uint32,address)" "0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F" "0x685Bc3aBDbAAa9E87E0CFe4B772e266c88Ae8e53" 10000000 20 "0x3b952c8C9C44e8Fe201e2b26F6B2200203214cfF")

forge verify-contract \
--verifier sourcify \
0x2522d533BcB8952fbAa7B7181699c0Da936EEc10 \
contracts/ERC20Tornado.sol:ERC20Tornado \
--root . \
--chain-id $ZIRCUIT_CHAIN_ID \
--constructor-args $(cast abi-encode "constructor(address,address,uint256,uint32,address)" "0x9BDCf71048DFd8ef1C03a7ae3EDe79F04A096B7F" "0x685Bc3aBDbAAa9E87E0CFe4B772e266c88Ae8e53" 100000000 20 "0x3b952c8C9C44e8Fe201e2b26F6B2200203214cfF")
