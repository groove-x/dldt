#/bin/bash
export DLDT_DIR=/media/waragai/DATA5/Downloads/github/dldt
export MODELS_DIR=$HOME/public_models/public
export IR_DIR=/media/waragai/DATA5/Downloads/github/dldt/ir_dir

python3 $DLDT_DIR/model-optimizer/mo.py --input_model $MODELS_DIR/squeezenet1.1/squeezenet1.1.caffemodel --data_type FP32 --output_dir $IR_DIR

./classification_sample_async -i $DLDT_DIR/inference-engine/samples/sample_data/car.png -m $IR_DIR/squeezenet1.1.xml -d CPU
