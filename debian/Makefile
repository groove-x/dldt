VERSION=$(shell head -n 1 VERSION)
PACKAGE_NAME=openvino

deb:
	@rm -f ${PACKAGE_NAME}_*.deb
	@rm -rf pkg-build
	rm -rf \
	  build/.editorconfig \
	  build/bin \
	  build/cmake \
	  build/CMakeLists.txt \
	  build/deployment_tools/inference_engine/samples \
	  build/deployment_tools/demo \
	  build/deployment_tools/tools \
	  build/install_dependencies \
	  build/LICENSE \
	  build/lib/cmake \
	  build/licenses \
	  build/python/python3.7/requirements.txt \
	  build/share \
	  build/VERSION
	mv build/deployment_tools/inference_engine/include/* build/include
	rm -rf build/deployment_tools/inference_engine/include
	mv build/deployment_tools/inference_engine/external/tbb/include/* build/include
	rm -rf build/deployment_tools/inference_engine/external/tbb/include
	mkdir -p build/lib/openvino
	find build/deployment_tools -name "*.xml" | xargs mv -t build/lib/openvino
	find build/deployment_tools -name "*.so" | xargs mv -t build/lib/openvino
	find build/deployment_tools -name "*.so.*" | xargs mv -t build/lib/openvino
	rm -rf build/deployment_tools
	mkdir -p build/lib/openvino/python3.7/site-packages
	mv build/python/python3.7/openvino build/lib/openvino/python3.7/site-packages
	rm -rf build/python
	bin/go-bin-deb generate --version ${VERSION}
