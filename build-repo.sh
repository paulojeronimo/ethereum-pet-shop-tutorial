#!/usr/bin/env bash
#
# Author: Paulo Jeronimo <paulojeronim@gmail.com>
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

source ./pet-shop.sh

d=ethereum-pet-shop-ftecm221
if [ -d $d ]
then
	echo "Directory \"$d\" already exists. It should be manually removed!"
	exit 1
fi

#
mkdir $d && cd $_
truffle unbox pet-shop

#
pet-shop init

#
pet-shop add contracts/Adoption.sol <<'EOF'
pragma solidity ^0.5.0;

contract Adoption {

}
EOF

#
pet-shop apply ../patches/01.patch 'Variable setup'

#
pet-shop apply ../patches/02.patch 'Your first function: Adopting a pet'

#
pet-shop apply ../patches/03.patch 'Your second function: Retrieving the adopters'

#
pet-shop add migrations/2_deploy_contracts.js <<'EOF'
var Adoption = artifacts.require("Adoption");

module.exports = function(deployer) {
  deployer.deploy(Adoption);
};
EOF

#
echo build >> .gitignore
git commit -am 'File .gitignore modified'

#
pet-shop add test/TestAdoption.sol <<'EOF'
pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption {
 // The address of the adoption contract to be tested
 Adoption adoption = Adoption(DeployedAddresses.Adoption());

 // The id of the pet that will be used for testing
 uint expectedPetId = 8;

 //The expected owner of adopted pet is this contract
 address expectedAdopter = address(this);

}
EOF

#
pet-shop apply ../patches/04.patch 'Testing the adopt() function'

#
pet-shop apply ../patches/05.patch "Testing retrieval of a single pet's owner"

#
pet-shop apply ../patches/06.patch "Testing retrieval of all pet owners"

#
pet-shop apply ../patches/07.patch 'Instantiating web3'

#
pet-shop apply ../patches/08.patch 'Instantiating the contract'

#
pet-shop apply ../patches/09.patch 'Getting The Adopted Pets and Updating The UI'

#
pet-shop apply ../patches/10.patch 'Handling the adopt() Function'
