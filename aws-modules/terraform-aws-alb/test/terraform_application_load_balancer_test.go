// See https://terratest.gruntwork.io/docs/ for full Terratest Documentation.

package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// TerraformModule tests, using default or provided values.
func TestApplicationLoadBalancer(t *testing.T) {
	t.Parallel()

	nameSuffix := fmt.Sprintf("-%s", random.UniqueId())

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located--relative to tests.
		TerraformDir: "..",

		// By default, tests will read input values from .auto.tfvars
		VarFiles: []string{".auto.tfvars"},

		// Variables can also be declared within this file directly.
		Vars: map[string]interface{}{
			"name_suffix": nameSuffix,
		},

		// Environment Variables can also be passed in to tests.
		// EnvVars: map[string]string{
		// 	"AWS_DEFAULT_REGION": awsRegion,
		// },

		// Retry this many times for non-fatal errors.
		MaxRetries: 3,
		// Wait this long between retrying again (in nanoseconds)
		TimeBetweenRetries: 5000000000, // 5 seconds
	}

	// Destroys our Terraform Module after it has been tested.
	defer terraform.Destroy(t, terraformOptions)

	// Performs a `terraform init` and `terraform apply` with to the module.
	terraform.InitAndApply(t, terraformOptions)

	// Test Assertions

	// examples:
	// actualValue := terraform.Output(t, terraformOptions, "some_module_output")
	// expectedValue := "some_module_output"

	// Actual Outputs
	actualSecurityGroupVpcID := terraform.Output(t, terraformOptions, "aws_security_group_vpc_id")
	actualSecurityGroupOwnerID := terraform.Output(t, terraformOptions, "aws_security_group_owner_id")
	actualSecurityGroupName := terraform.Output(t, terraformOptions, "aws_security_group_name")
	actualSecurityGroupDescription := terraform.Output(t, terraformOptions, "aws_security_group_description")
	actualAlbDNSName := terraform.Output(t, terraformOptions, "aws_lb_dns_name")
	actualAlbZoneID := terraform.Output(t, terraformOptions, "aws_lb_zone_id")
	actualAlbTargetGroupName := terraform.Output(t, terraformOptions, "aws_lb_target_group_name")

	// Expected Outputs
	expectedSecurityGroupVpcID := "vpc-0bca9872fc56ac008"
	expectedSecurityGroupOwnerID := "646738440247"
	expectedSecurityGroupName := "test-test-sg" + nameSuffix
	expectedSecurityGroupDescription := "Allow ALB Traffic"
	expectedAlbDNSName := "test-test-alb-"
	expectedAlbZoneID := "Z35SXDOTRQ7X7K"
	expectedAlbTargetGroupName := "test-test-tg" + nameSuffix

	// Assertions
	assert.Equal(t, actualSecurityGroupVpcID, expectedSecurityGroupVpcID)
	assert.Equal(t, actualSecurityGroupOwnerID, expectedSecurityGroupOwnerID)
	assert.Equal(t, actualSecurityGroupName, expectedSecurityGroupName)
	assert.Equal(t, actualSecurityGroupDescription, expectedSecurityGroupDescription)
	assert.Contains(t, actualAlbDNSName, expectedAlbDNSName)
	assert.Equal(t, actualAlbZoneID, expectedAlbZoneID)
	assert.Equal(t, actualAlbTargetGroupName, expectedAlbTargetGroupName)
	// assert.Contains(t, someString, someSubString)
	// assert.NotContains(t, someString, someSubString)
}
