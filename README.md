# openvino for debian stretch

## 概要

Intel の OpenVINO を debian stretch (amd64) にインストールできるようにビルド設定を加えています。Intel の公式では debian 向けのパッケージが提供されていません。

- base version: 2021.1

## ビルド

[Build OpenVINO™ Inference Engine](https://github.com/openvinotoolkit/openvino/blob/2021.1/build-instruction.md) を参考にビルドしました。

- cmake 3.13 以上を要求されたため、backports から cmake をインストール
- cmake のビルドに必要だったため、backports-sloppy から libarchive13 をインストール
- install dependency は ubuntu 向けの設定を参考に設定
- "intel graphics compute runtime for opencl" は libc6 のバージョンが整合する最新のものを選択
- python 実行環境は `gx-python3.7` を利用
- サンプルやテスト類を極力排除するオプションを指定
- OpenCV のビルドは無効化
- Python のビルドを有効化

詳細は `.circleci/config.yml` を参照して下さい。

## debian package の作り方

CMakeLists.txt  に cpack 設定を追加する代わりに、ローカルに展開してからディレクトリ配置を再構成し、go-bin-debでdebパッケージを生成しています。

- ライブラリ類は `/usr/lib` および `/usr/lib/openvino` に集約
- `/etc/ld.so.conf.d/openvino.conf` にライブラリパスを設定
- `postinst`で`ldconfig`を実行してライブラリパスのキャッシュを更新

詳細は `debian/Makefile` を参照して下さい。

## パッケージの使い方

gx-python3.7 と一緒に利用して下さい。`/usr/lib/openvino/python3.7/site-packages` にパスを通せば使えるようになります。例えば、venvを使う場合は下記のようになります。

```bash
$ python3.7 -m venv venv
$ source venv/bin/activate
(venv)$ pip install -U pip numpy opencv-python
(venv)$ echo /usr/lib/openvino/python3.7/site-packages > venv/lib/python3.7/site-packages/openvino.pth
(venv)$ python
>>> import openvino.inference_engine
>>> from openvino.inference_engine import IENetwork, IECore
>>> ie = IECore()
```

## opencv との関係

OpenCV の API (`cv2.dnn`) を使わないなら、このまま任意の OpenCV と一緒に利用できます。OpenCV の API を利用する場合は、このビルドをベースとして OpenCV をカスタムビルドする必要があります（未対応）。


---

# [OpenVINO™ Toolkit](https://01.org/openvinotoolkit) - Deep Learning Deployment Toolkit repository
[![Stable release](https://img.shields.io/badge/version-2021.1-green.svg)](https://github.com/openvinotoolkit/openvino/releases/tag/2021.1)
[![Apache License Version 2.0](https://img.shields.io/badge/license-Apache_2.0-green.svg)](LICENSE)

This toolkit allows developers to deploy pre-trained deep learning models
through a high-level C++ Inference Engine API integrated with application logic.

This open source version includes two components: namely [Model Optimizer] and
[Inference Engine], as well as CPU, GPU and heterogeneous plugins to accelerate
deep learning inferencing on Intel® CPUs and Intel® Processor Graphics.
It supports pre-trained models from the [Open Model Zoo], along with 100+ open
source and public models in popular formats such as Caffe\*, TensorFlow\*,
MXNet\* and ONNX\*.

## Repository components:
* [Inference Engine]
* [Model Optimizer]

## License
Deep Learning Deployment Toolkit is licensed under [Apache License Version 2.0](LICENSE).
By contributing to the project, you agree to the license and copyright terms therein
and release your contribution under these terms.

## Documentation
* [OpenVINO™ Release Notes](https://software.intel.com/en-us/articles/OpenVINO-RelNotes)
* [OpenVINO™ Inference Engine Build Instructions](build-instruction.md)
* [Get Started with Deep Learning Deployment Toolkit on Linux](get-started-linux.md)\*
* [Introduction to Deep Learning Deployment Toolkit](https://docs.openvinotoolkit.org/latest/_docs_IE_DG_Introduction.html)
* [Inference Engine Developer Guide](https://docs.openvinotoolkit.org/latest/_docs_IE_DG_Deep_Learning_Inference_Engine_DevGuide.html)
* [Model Optimizer Developer Guide](https://docs.openvinotoolkit.org/latest/_docs_MO_DG_Deep_Learning_Model_Optimizer_DevGuide.html)

## How to Contribute
See [CONTRIBUTING](./CONTRIBUTING.md) for contribution to the code.
See [CONTRIBUTING_DOCS](./CONTRIBUTING_DOCS.md) for contribution to the documentation.
Thank you!

## Support
Please report questions, issues and suggestions using:

* The `openvino` [tag on StackOverflow]\*
* [GitHub* Issues](https://github.com/openvinotoolkit/openvino/issues)
* [Forum](https://software.intel.com/en-us/forums/computer-vision)

---
\* Other names and brands may be claimed as the property of others.

[Open Model Zoo]:https://github.com/opencv/open_model_zoo
[Inference Engine]:https://software.intel.com/en-us/articles/OpenVINO-InferEngine
[Model Optimizer]:https://software.intel.com/en-us/articles/OpenVINO-ModelOptimizer
[tag on StackOverflow]:https://stackoverflow.com/search?q=%23openvino
