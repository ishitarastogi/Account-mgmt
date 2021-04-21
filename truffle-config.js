module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*" // Match any network id
    }
  },

     compilers: {
      solc: {
        version: "^0.7.0", // A version or constraint - Ex. "^0.5.0"
                           // Can also be set to "native" to use a native solc
        docker: false, // Use a version obtained through docker
        parser: "solcjs",  // Leverages solc-js purely for speedy parsing
        settings: {
          optimizer: {
            enabled: false,
            runs: 200   // Optimize for how many times you intend to run the code
          },
          evmVersion: "istanbul" // Default: "istanbul"
        },
       
      }
    }
};