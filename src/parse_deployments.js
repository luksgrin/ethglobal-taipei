const fs = require('fs');
const path = require('path');

// Define the base directory path
const baseDir = path.join(__dirname, 'broadcast', 'Deploy.s.sol');

// Object to store the parsed JSON data for each subdirectory
const results = {
    deployments: {},
};

// Read all entries in the base directory
const subdirs = fs.readdirSync(baseDir, { withFileTypes: true });

// Process each entry that is a directory
subdirs.forEach((dirent) => {
  if (dirent.isDirectory()) {
    const subdirName = dirent.name;
    const filePath = path.join(baseDir, subdirName, 'run-latest.json');
    
    // Check if the file exists before attempting to read it
    if (fs.existsSync(filePath)) {
      try {
        const fileContent = fs.readFileSync(filePath, 'utf8');
        results.deployments[`netId${subdirName}`] = {};
        // Parse JSON content
        let transactions = JSON.parse(fileContent).transactions;

        transactions
        .filter((transaction) => transaction.transactionType === 'CREATE')
        .forEach((transaction) => {
            const contractName = transaction.contractName ? transaction.contractName : "MiMCSponge";
            const contractAddress = transaction.contractAddress;

            if (["Verifier", "MiMCSponge"].includes(contractName)) {
                results.deployments[`netId${subdirName}`][contractName] = contractAddress;
            } else if (contractName === "ETHTornado") {

                if (!results.deployments[`netId${subdirName}`].eth) {
                    results.deployments[`netId${subdirName}`].eth = {
                        instanceAddress: {},
                        symbol: "ETH",
                        decimals: 18
                    };
                }

                results
                .deployments
                [`netId${subdirName}`]
                .eth
                .instanceAddress
                [transaction.arguments[2]/1e18] = contractAddress;
            } else {

                let erc20Address = transaction.arguments[4].toLowerCase();

                if (!results.deployments[`netId${subdirName}`][erc20Address]) {
                    results.deployments[`netId${subdirName}`][erc20Address] = {
                        instanceAddress: {}
                    };
                }

                results
                .deployments
                [`netId${subdirName}`]
                [erc20Address]
                .instanceAddress
                [transaction.arguments[2]] = contractAddress;
            }
        });
      } catch (err) {
        console.error(`Error reading or parsing file in ${subdirName}:`, err);
      }
    } else {
      console.warn(`File not found: ${filePath}`);
    }
  }
});

// Create the config file
const outputContent = `require('dotenv').config()

module.exports = ${JSON.stringify(results, null, 2)}
`;

const outputFile = path.join(__dirname, 'src', 'anvil_config.js');

fs.writeFileSync(outputFile, outputContent, 'utf8');
console.log(`File written to ${outputFile}`);
