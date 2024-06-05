require 'json'

control "platform-vpc-exists" do
  title "Check that platform VPC exists in the region"
  tag "spec"

  instance = input('instance')
  aws_region = input('aws_region')
  vpc_cidr = input('vpc_cidr')
  vpc_name = "#{instance}-vpc"
  client = Aws::EC2::Client.new(region: "#{aws_region}")
  vpc = client.describe_vpcs({
     filters: [
       { name: "tag:Name", values: ["#{vpc_name}"] }
     ]
   })
  vpc_id = vpc.vpcs[0].vpc_id

  describe aws_vpc(vpc_id) do

    it { should exist }

    its ('cidr_block') { should eq "#{vpc_cidr}" }
  end
end
