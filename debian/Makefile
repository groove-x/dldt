VERSION=$(shell head -n 1 VERSION)
PACKAGE_NAME=openvino

deb:
	@rm -f ${PACKAGE_NAME}_*.deb
	@rm -rf pkg-build
	bin/go-bin-deb generate --version ${VERSION}
