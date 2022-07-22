## DIGITAL LAND : Running pipelines locally in cloud shell  
 
<p>&nbsp;</p>    

### IMPORTANT NOTES

-----
 **NOTE 1**: If you went away and your Google Cloud Shell timed out you will need to prepare/activate 
 the dependencies again, to do so repeat steps from 04 onwards. This happens because cloud shell
 is run on a free VM from google cloud, when it times out it clears your VM and when you come back
 you get a new VM. Because some parts of the dependencies are installed in the OS level this means
 some dependencies got lost and need to be restored. All will work fine if you start from step 04. 

-----
 **NOTE 2**: All steps from 05 onwards need to be run inside a virtual 
 environment because the dependencies were installed inside it to avoid 
 conflicts. The easy way to check if you are in a virtual env is by looking 
 at your terminal, it should show your home folder inside parantheses as the 
 first thing on the left of the active line. My home folder is 'henrique_farina', 
 so I see:
         
    (henrique_farina) henrique_farina@cloudshell:~$
    this means:
    (folder_where_a_virtual_env_is_active) user@cloudshell::~$
If you don't see the (parantheses) part, it means you are not inside the virtual env, run step 05 to correct it.

-----
**NOTE 3**: If you want to clean the pipeline/collection state to run a new collection or pipeline, you don't need
to run the installation steps again (unless your cloud shell timed out). All you need do do is run: 

    bash 06-clean-collection.sh        
 
and then repeat all steps from 06 onwards.

-----
**NOTE 4**: Please note that at the present stage the scripts are only a collection of bash commands executed in a specific order, this means that the prints you see on the screen when the script is running (e.g. 'Variables setting step completed') don't imply the step completed without errors, it just means the code was executed up to that point, errors should show in the terminal as they happen.

-----

<p>&nbsp;</p>

## STEPS TO RUN THE PIPELINE LOCALLY ON CLOUD SHELL


<p>&nbsp;</p>

01. Start your cloud shell by going to: https://shell.cloud.google.com/

02. Click 'Open home workspace'

03. Upload the files of this repo: file > upload files > select all .sh files in this repo.

04. To install all dependencies run:

        bash 01-package-clone-and-general-setup.sh
        
05. To activate/enter the virtual environment run:

        pipenv shell

06. Open the file '03-prepare-collection.sh' and set the variable **COLLECTION_REPO_NAME** to the collection you want to test/work with.

07. To prepare folders and files for a collection:
    
        bash 03-prepare-collection.sh
    (Note: this step downloads the endpoint.csv and source.csv from the collection repository you can change them after this step to run any tests but remember that if you re-run this step they will be retrieved again and reflect again the originals in the repository)

08. You can now make any editions/changes you want to test in the files: 
    
        collection/endpoint.csv
        collection/source.csv
        var/cache/organisation.csv
        pipeline/*.csv
    (For example, you might want to keep only 1 specific endpoint and the respective source of that endpoint):

09. To collect the resources run:

        bash 04-collect-resources.sh
    (Note: this step is able to collect several resources at once and they all will be saved at collection/resource and the logs of the collection will be saved at collection/log/)

10. This step allow you to proccess only one resource at a time. To do so you will need to fill in a few variables inside the file '05-run-pipeline-transformations.sh'. If you need to process more than one resource you will need to repeat this step each time with the appropriate variables:
    
        DATASET: this is usually the column 'collection' of the 'collection/source.csv' file
        ENDPOINT: this is the has value in the column 'endpoint' of the 'collection/source.csv' file
        ORGANISATION: this is the has value in the column 'organisation' of the 'collection/source.csv' file
        ENTRYDATE: for testing purposes any date in the format 'YYYY-MM-DD' can be used 
        RESOURCE: this is the name (also a hash) of the file collected in the folder 'collection/resource/'.
    
    (Note: to get the resource name-hash it is easier if you right click on the file and select 'Copy path' and than get rid of the folder, keeping only the hash)

            For example, from:
            /home/henrique_farina/collection/resource/6c961fcd2c76a1602a98f309dc7bffe4323b3192bb839c9c773b4365f9a2ec41
    
            You would fill in:    
            RESOURCE='6c961fcd2c76a1602a98f309dc7bffe4323b3192bb839c9c773b4365f9a2ec41'
    

11. Once you filled in the variables mentioned, you can run the pipeline for the resource with:

        bash 05-run-pipeline-transformations.sh

## Now you should be able to:
   
    a. See any errors in your terminal as the pipeline runs
    b. Check any intermediate files and logs in you file explorer, these folders should be of your interest:
            collection/resource
            collection/log
            transformed/
            issue/
            my_temp_dir/
            dataset/
            hoiseted/
