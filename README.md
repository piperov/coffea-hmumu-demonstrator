# coffea-hmumu-demonstrator
Examples of CMS user analysis using COFFEA framework 

Before runnning this demonstrator on Hammer, one needs to prepare a conda environment in the following way:
```
ssh hammer

ml anaconda/5.3.1-py37
conda create --name hmumu_coffea_demonstrator python=3.7
source activate hmumu_coffea_demonstrator
pip install --user --upgrade coffea
conda install nb_conda
conda install -c conda-forge pytest xrootd keras dask dask-jobqueue jupyterlab nodejs
pip install dask_labextension
jupyter labextension install dask-labextension
pip install jupyterlab-sparkmonitor
jupyter labextension install jupyterlab_sparkmonitor
jupyter serverextension enable --py sparkmonitor
ipython profile create --ipython-dir=.ipython
echo "c.InteractiveShellApp.extensions.append('sparkmonitor.kernelextension')" >>  .ipython/profile_default/ipython_config.py
source deactivate
```

Once the 'hmumu_coffea_demonstrator' conda environment is prepared, the demonstrator can be run e.g. in a ThinLinc (aka "Remote Desktop") session on the Hammer Frontend:  

```
ssh hammer-xNNN #(your dedicated interactive node)
source activate hmumu_coffea_demonstrator
git clone git@github.com:piperov/coffea-hmumu-demonstrator.git
cd coffea-hmumu-demonstrator
. setup_proxy.sh
jupyther lab
```

Then, inside the Jupyther Lab session, start a new Terminal from which you will create and control your scheduler:  
```
ipython -i slurm_cluster_prep.py
In [1]: cluster = SLURMCluster( project='cms-express', queue='hammer-c', cores=1, memory='8.2GB', walltime='48:00:00', job_extra=['--qos=normal', '-o dask_job.%j.%N.out','-e dask_job.%j.%N.error'])

In [2]: cluster.scale(64)

In [3]: print(cluster)
```

While waiting for enough workers to get started, open the `DASK_analyzer.ipynb` and  proceed to the preparatory steps and the selecting and loading of the input datasets - everything up to the "Run the DASK executor" section.  
Then, when `print(cluster)` shows enough DASK workers running, proceed with running the DASK executor.
Finally, plot the results.

For the SPARK executor, start the `SPARK_analyzer.ipynb` instead.
