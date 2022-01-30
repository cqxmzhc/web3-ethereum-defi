# Compile all of Sushiswap fiels
sushi:
	@(cd sushiswap && yarn install && yarn build) > /dev/null
	@echo "Sushi is ready"

# Extract all compilation artifacts from Sushi to our abi/ dump
copy-abi: sushi
	find sushiswap/artifacts/contracts -iname "*.json" -not -iname "*.dbg.json" -exec cp {} smart_contracts_for_testing/abi \;

all: copy-abi

# Export the dependencies, so that Read the docs can build our API docs
# See: https://github.com/readthedocs/readthedocs.org/issues/4912
rtd-dep-export:
	poetry export --without-hashes --dev -f requirements.txt --output requirements-dev.txt

# Build docs locally
build-docs:
	@(cd docs && make html)