require('dotenv').config()

module.exports = {
  "deployments": {
    "netId31337": {
      "Verifier": "0xe7f1725e7734ce288f8367e1bb143e90bb3f0512",
      "MiMCSponge": "0x9fe46736679d2d9a65f0992f2272de9f3c7fa6e0",
      "eth": {
        "instanceAddress": {
          "1": "0xdc64a140aa3e981100a9beca4e685f962f0cf6c9",
          "10": "0x5fc8d32690cc91d4c39d9d3abcbd16989f875707",
          "100": "0x0165878a594ca255338adfa4d48449f69242eb8f",
          "0.1": "0xcf7ed3acca5a467e9e704c703e8d87f634fb0fc9"
        },
        "symbol": "ETH",
        "decimals": 18
      },
      "0x5fbdb2315678afecb367f032d93f642f64180aa3": {
        "instanceAddress": {
          "1000000000000000000": "0xa513e6e4b8f2a923d98304ec87f64353c4d5c853",
          "10000000000000000000": "0x2279b7a0a67db372996a5fab50d91eaa73d2ebe6",
          "100000000000000000000": "0x8a791620dd6260079bf849dc5567adc3f2fdc318"
        }
      }
    }
  }
}
