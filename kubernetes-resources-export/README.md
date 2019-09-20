# Export all resources from kubernetes
Bash for export all kubernetes resources via kubectl
Tested on linux mint.

Arguments:
 - path to file for KUBECONFIG(if empty uses preconfigured)

Asks you to install yq(yaml parser) with apt

exports resources in folder ./exported with the next structure:

    exported
      (api resource name 1)
        original.yaml                    
        tailed.yaml                                                                                           
        (api resource name 1)-[(namespace if exitsts in metadata)-](resource name from metadata 1).yaml   
        (api resource name 1)-[(namespace if exitsts in metadata)-](resource name from metadata 2).yaml   
        ...
        (api resource name 1)-[(namespace if exitsts in metadata)-](resource name from metadata n).yaml   
      (api resource name 2)
        original.yaml                    
        tailed.yaml                      
        (api resource name 2)-[(namespace if exitsts in metadata)-](resource name from metadata 1).yaml   
        (api resource name 2)-[(namespace if exitsts in metadata)-](resource name from metadata 2).yaml  
        ...
        (api resource name n)-[(namespace if exitsts in metadata)-](resource name from metadata 2).yaml  
      ...
      (api resource name n)
        original.yaml                    
        tailed.yaml                      
        (api resource name n)-[(namespace if exitsts in metadata)-](resource name from metadata 1).yaml   
        (api resource name n)-[(namespace if exitsts in metadata)-](resource name from metadata 2).yaml  
        ...
        (api resource name n)-[(namespace if exitsts in metadata)-](resource name from metadata n).yaml  


original.yaml - raw resources list - kubectl get (api resource name 1) -A -o yaml > original.yaml
tailed.yaml - temporary file for ready for csplit - ignore it    

