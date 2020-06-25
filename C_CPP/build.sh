# build all the templates and clean afterwards
#!/bin/bash
make -j18 PROJECT=PC CONFIG=release
make -j18 PROJECT=PC CONFIG=debug
make -j18 PROJECT=PC clean
