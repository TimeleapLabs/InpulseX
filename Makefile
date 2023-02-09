abi:
	cd pegswap && npx hardhat export-abi && \
	cd ../staking && npx hardhat export-abi && \
	cd ../token && npx hardhat export-abi && \
	cd ../UI && \
	mkdir -p ./lib/abi && \
	rm -rf ./lib/abi && \
	mkdir -p ./lib/abi && \
	cp -r ../pegswap/abi ./lib/abi/pegswap && \
	cp -r ../token/abi ./lib/abi/token && \
	cp -r ../staking/abi ./lib/abi/staking
