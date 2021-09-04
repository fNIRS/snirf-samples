SNIRF Sample Data Files
============================================================

* License: All files in this package are in the public domain
* SNIRF Specification: https://github.com/fNIRS/snirf
* URL: https://github.com/fNIRS/snirf-samples

**Table of content**

- [How to read sample data files](#how-to-read-sample-data-files)
  * [Using data in Python](#using-data-in-python)
    + [SNIRF files](#snirf-files)
    + [JSNIRF/JSON files](#jsnirfjson-files)
    + [Binary JSNIRF files](#binary-jsnirf-files)
    + [How to access individual data records in Python](#how-to-access-individual-data-records-in-python)
  * [Using data in MATLAB/Octave](#using-data-in-matlaboctave)
    + [SNIRF files](#snirf-files)
    + [JSNIRF/JSON files](#jsnirfjson-files)
    + [Binary JSNIRF files](#binary-jsnirf-files)
    + [How to access individual data records in MATLAB](#how-to-access-individual-data-records-in-matlab)
- [Contribute to this project](#contribute-to-this-project)

## Overview

This repository provides sample data files to facilitate software developers
adopting and testing supports for [Shared Near Infrared File Format (SNIRF)](https://github.com/fNIRS/snirf/blob/master/snirf_specification.md)
v1.0 files.

This repository contains 3 types of sample data files

- The SNIRF data files (`.snirf`) are actually HDF5 files and can be read
  and write in most software platforms where HDF5 is supported. The datasets 
  in the `.snirf` files are set so that data field creation order are preserved.
  One must use approprate HDF5 reading API to retrieve the field creation order.

- The text-based [JSNIRF](https://github.com/OpenJData/jsnirf) data files 
  (`.jnirs`) are actually [JSON](http://json.org) files with 
  [JData-compliant annotations](http://openjdata.org). The JSNIRF/JSON files
  are broadly supported, including platforms where HDF5 is not avaible
  such as GNU Octave or MATLAB older than R2011a. The `.jnirs` files can be opened
  by a text editor and are directly human-readable.

- The binary [JSNIRF](https://github.com/OpenJData/jsnirf) data files 
  (`.bnirs`) are actually [BJData/UBJSON](https://github.com/OpenJData/bjdata) 
  files with [JData-compliant annotations](http://openjdata.org). The BJData/UBJSON 
  files are binary JSON files that provides smaller file sizes and fast parsing.


## How to read sample data files
### Using data in Python

To load the data in python, one can use the below sample codes

#### SNIRF files

The `.snirf` files are simply renamed HDF5 (`.h5`) files and thus 
can be read/written by the `python-h5py` module. To read/write `.snirf`
files, one need to install the below software packages (on Debian/Ubuntu)

```
sudo apt-get install python-h5py python-numpy
```
Once these tools are installed, one can start python and run
```
import h5py
import numpy as np

dat=h5py.File('datafile.snirf','r')
d1=np.array(dat.get('/nirs/data1/dataTimeSeries'));
```


#### JSNIRF/JSON files

To read the text JSNIRF files (`.jnirs`, which is a valid JSON file), one needs to install 
the [jdata module](https://pypi.org/project/jdata) via

```
pip install jdata --user
```

then open python, and run
```
import jdata as jd
from collections import OrderedDict
data=jd.loadt('datafile.jnirs',object_pairs_hook=OrderedDict);
```
to load the JSNIRF/JSON (`.jnirs`) file. The output `data` is a `dict` object
containing the full SNIRF data structure.

#### Binary JSNIRF files

To read the binary JSNIRF files (`.bnirs`), one needs to install the 
[bjdata module](https://pypi.org/project/bjdata) in addition to
[jdata](https://pypi.org/project/jdata)
```
pip install jdata --user
pip install bjdata --user
```
and then load the binary jdata file using
```
import jdata as jd
import bjdata
from collections import OrderedDict

data=jd.loadb('datafile.bnirs',object_pairs_hook=OrderedDict);
```
Both `bjdata` and `jdata` moduels can be installed on Debian Bullseye and
Ubuntu 21.04 or newer via 
```
sudo apt-get install python3-jdata python3-bjdata
```
For Ubuntu 14.04-20.04, please use the following PPA:
```
sudo add-apt-repository ppa:fangq/ppa
sudo apt-get update
sudo apt-get install python3-jdata python3-bjdata
```


#### How to access individual data records in Python

Once the data is loaded in Python, the full data structured is typically stored as a nested `dict` object.
One can access the individual subfields via python's standard object indexing and reference methods. For 
example, 

```
  data['formatVersion']   # this prints the formatVersion subfield in the top level
  data['data1']['dataTimeSeries']      # retrieve the data array as an numpy array
  data['metadataTags']['SubjectID']    # print the SubjectID in the metadataTags field
```

### Using data in MATLAB/Octave

To load the data in MATLAB/Octave, one can use the below sample codes

#### SNIRF files

The `.snirf` files can be loaded using 
- MATLAB's HDF5 API
- [EasyH5 toolbox](https://github.com/fangq/zmat) with [JSNIRFY toolbox](https://github.com/fangq/jsnirfy)
- [snirf_homer3](https://github.com/fNIRS/snirf_homer3) toolbox


Once these tools are installed, one can start MATLAB and run
```
data=loadsnirf('datafile.snirf');
```


#### JSNIRF/JSON files

The `.jnirs` files can be loaded using 
- MATLAB's `jsondecode` function with `jdatadecode` in [JSONLab toolbox](https://github.com/fangq/jsonlab) and [ZMat toolbox](https://github.com/fangq/zmat)
or
- [JSNIRFY toolbox](https://github.com/fangq/jsnirfy) combined with 
- [JSONLab toolbox](https://github.com/fangq/jsonlab) and 
- [ZMat toolbox](https://github.com/fangq/zmat) (not needed for MATLAB but required for Octave)

Once these tools are installed, one can start MATLAB and run

```
data=loadjsnirf('datafile.jnirs');
```

#### Binary JSNIRF files

The `.bnirs` files can be loaded using 
- [JSNIRFY toolbox](https://github.com/fangq/jsnirfy) combined with 
- [JSONLab toolbox](https://github.com/fangq/jsonlab) and 
- [ZMat toolbox](https://github.com/fangq/zmat) (not needed for MATLAB but required for Octave)

and then load the binary jdata file using
```
data=loadjsnirf('datafile.bnirs');
```

#### How to access individual data records in MATLAB

Once the data is loaded in Python, the full data structured is typically stored as a nested `dict` object.
One can access the individual subfields via python's standard object indexing and reference methods. For 
example, 

```
  data.formatVersion   % this prints the formatVersion subfield in the top level
  data.data{1}.dataTimeSeries    % retrieve the data array
  data.metadataTags.SubjectID    % print the SubjectID in the metadataTags field
```

## Contribute to this project

Please submit your bug reports, feature requests and questions to the Github Issues page at

https://github.com/fNIRS/snirf/issues

Please feel free to fork our software, making changes, and submit your revision back
to us via "Pull Requests".

