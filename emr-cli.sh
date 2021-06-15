# Create a Spark cluster
aws emr create-cluster \
--name "Airtel to Jio migration" \
--release-label emr-5.33.0 \
--applications Name=Spark \
--ec2-attributes KeyName=alvis_mumbai \
--instance-type m5.xlarge \
--instance-count 3 \
--use-default-roles
				
j-1JY3LK9YZB74
# Check your cluster status
aws emr describe-cluster --cluster-id {{myClusterId}}
						
# Get ClusterId of the cluster 

aws emr list-clusters --cluster-states WAITING
							
# Add Step

aws emr add-steps \
--cluster-id {{myClusterId}} \
--steps Type=Spark,Name="Airtel to Jio migration",ActionOnFailure=CONTINUE,Args=s3://my-website-alvisf/vendor_migration.py,--data_source1,s3://my-website-alvisf/Vendor1.csv,--data_source2,s3://my-website-alvisf/Vendor2.csv,--output_uri,s3://athena-dest/emrout

# Query the status of the step

aws emr describe-step --cluster-id myClusterId --step-id {{s-1xxxxxxxxxxxxA}}

# Delete Cluster

aws emr terminate-clusters --cluster-ids myClusterId