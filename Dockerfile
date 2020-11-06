FROM nvcr.io/nvidia/l4t-ml:r32.4.4-py3

# How to Run:
# sudo docker run --runtime nvidia --rm --network host -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix --ipc=host --device=/dev/video0:/dev/video0 --privileged -it audience-meas /bin/bash


RUN mkdir -p /workspace
WORKDIR /workspace
RUN pip3 install scikit-build cmake opencv-python

WORKDIR /workspace
RUN git clone https://github.com/NVIDIA-AI-IOT/torch2trt
WORKDIR /workspace/torch2trt
RUN python3 setup.py install --plugins
RUN pip3 install tqdm cython pycocotools
RUN apt-get install python3-matplotlib

WORKDIR /workspace
RUN git clone https://github.com/NVIDIA-AI-IOT/trt_pose
WORKDIR /workspace/trt_pose
RUN python3 setup.py install

WORKDIR /workspace
RUN git clone https://github.com/NVIDIA-AI-IOT/jetcam
WORKDIR /workspace/jetcam
RUN python3 setup.py install 


WORKDIR /workspace/trt_pose/tasks
RUN git clone https://github.com/hmurari/trtpose-human-pose-weights.git 
RUN cp trtpose-human-pose-weights/*.pth human_pose/


