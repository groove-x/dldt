VERSION=$(shell head -n 1 VERSION)
PACKAGE_NAME=openvino

deb:
	@rm -f ${PACKAGE_NAME}_*.deb
	@rm -rf pkg-build
	rm -rf build/deployment_tools/inference_engine/samples build/deployment_tools/demo
	bin/go-bin-deb generate --version ${VERSION}
