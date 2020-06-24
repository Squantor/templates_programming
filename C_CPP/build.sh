# build all the templates and clean afterwards
#!/bin/bash
make -j18 PROJECT=template_PC config=release
make -j18 PROJECT=template_PC config=debug
make -j18 PROJECT=template_PC clean
