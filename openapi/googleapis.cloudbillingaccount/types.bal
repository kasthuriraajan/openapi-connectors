// Copyright (c) 2022 WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Configurations related to client authentication
    http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
|};

# Provides settings related to HTTP/1.x protocol.
public type ClientHttp1Settings record {|
    # Specifies whether to reuse a connection for multiple requests
    http:KeepAlive keepAlive = http:KEEPALIVE_AUTO;
    # The chunking behaviour of the request
    http:Chunking chunking = http:CHUNKING_AUTO;
    # Proxy server related options
    ProxyConfig proxy?;
|};

# Proxy server configurations to be used with the HTTP client endpoint.
public type ProxyConfig record {|
    # Host name of the proxy server
    string host = "";
    # Proxy server port
    int port = 0;
    # Proxy server username
    string userName = "";
    # Proxy server password
    @display {label: "", kind: "password"}
    string password = "";
|};

# OAuth2 Refresh Token Grant Configs
public type OAuth2RefreshTokenGrantConfig record {|
    *http:OAuth2RefreshTokenGrantConfig;
    # Refresh URL
    string refreshUrl = "https://accounts.google.com/o/oauth2/token";
|};

# Associates `members` with a `role`.
public type Binding record {
    # Represents a textual expression in the Common Expression Language (CEL) syntax. CEL is a C-like expression language. The syntax and semantics of CEL are documented at https://github.com/google/cel-spec. Example (Comparison): title: "Summary size limit" description: "Determines if a summary is less than 100 chars" expression: "document.summary.size() < 100" Example (Equality): title: "Requestor is owner" description: "Determines if requestor is the document owner" expression: "document.owner == request.auth.claims.email" Example (Logic): title: "Public documents" description: "Determine whether the document should be publicly visible" expression: "document.type != 'private' && document.type != 'internal'" Example (Data Manipulation): title: "Notification string" description: "Create a notification string with a timestamp." expression: "'New message received at ' + string(document.create_time)" The exact variables and functions that may be referenced within an expression are determined by the service that evaluates it. See the service documentation for additional information.
    Expr condition?;
    # Specifies the identities requesting access for a Cloud Platform resource. `members` can have the following values: * `allUsers`: A special identifier that represents anyone who is on the internet; with or without a Google account. * `allAuthenticatedUsers`: A special identifier that represents anyone who is authenticated with a Google account or a service account. * `user:{emailid}`: An email address that represents a specific Google account. For example, `alice@example.com` . * `serviceAccount:{emailid}`: An email address that represents a service account. For example, `my-other-app@appspot.gserviceaccount.com`. * `group:{emailid}`: An email address that represents a Google group. For example, `admins@example.com`. * `deleted:user:{emailid}?uid={uniqueid}`: An email address (plus unique identifier) representing a user that has been recently deleted. For example, `alice@example.com?uid=123456789012345678901`. If the user is recovered, this value reverts to `user:{emailid}` and the recovered user retains the role in the binding. * `deleted:serviceAccount:{emailid}?uid={uniqueid}`: An email address (plus unique identifier) representing a service account that has been recently deleted. For example, `my-other-app@appspot.gserviceaccount.com?uid=123456789012345678901`. If the service account is undeleted, this value reverts to `serviceAccount:{emailid}` and the undeleted service account retains the role in the binding. * `deleted:group:{emailid}?uid={uniqueid}`: An email address (plus unique identifier) representing a Google group that has been recently deleted. For example, `admins@example.com?uid=123456789012345678901`. If the group is recovered, this value reverts to `group:{emailid}` and the recovered group retains the role in the binding. * `domain:{domain}`: The G Suite domain (primary) that represents all the users of that domain. For example, `google.com` or `example.com`. 
    string[] members?;
    # Role that is assigned to `members`. For example, `roles/viewer`, `roles/editor`, or `roles/owner`.
    string role?;
};

# An Identity and Access Management (IAM) policy, which specifies access controls for Google Cloud resources. A `Policy` is a collection of `bindings`. A `binding` binds one or more `members` to a single `role`. Members can be user accounts, service accounts, Google groups, and domains (such as G Suite). A `role` is a named list of permissions; each `role` can be an IAM predefined role or a user-created custom role. For some types of Google Cloud resources, a `binding` can also specify a `condition`, which is a logical expression that allows access to a resource only if the expression evaluates to `true`. A condition can add constraints based on attributes of the request, the resource, or both. To learn which resources support conditions in their IAM policies, see the [IAM documentation](https://cloud.google.com/iam/help/conditions/resource-policies). **JSON example:** { "bindings": [ { "role": "roles/resourcemanager.organizationAdmin", "members": [ "user:mike@example.com", "group:admins@example.com", "domain:google.com", "serviceAccount:my-project-id@appspot.gserviceaccount.com" ] }, { "role": "roles/resourcemanager.organizationViewer", "members": [ "user:eve@example.com" ], "condition": { "title": "expirable access", "description": "Does not grant access after Sep 2020", "expression": "request.time < timestamp('2020-10-01T00:00:00.000Z')", } } ], "etag": "BwWWja0YfJA=", "version": 3 } **YAML example:** bindings: - members: - user:mike@example.com - group:admins@example.com - domain:google.com - serviceAccount:my-project-id@appspot.gserviceaccount.com role: roles/resourcemanager.organizationAdmin - members: - user:eve@example.com role: roles/resourcemanager.organizationViewer condition: title: expirable access description: Does not grant access after Sep 2020 expression: request.time < timestamp('2020-10-01T00:00:00.000Z') - etag: BwWWja0YfJA= - version: 3 For a description of IAM and its features, see the [IAM documentation](https://cloud.google.com/iam/docs/).
public type Policy record {
    # Specifies cloud audit logging configuration for this policy.
    AuditConfig[] auditConfigs?;
    # Associates a list of `members` to a `role`. Optionally, may specify a `condition` that determines how and when the `bindings` are applied. Each of the `bindings` must contain at least one member.
    Binding[] bindings?;
    # `etag` is used for optimistic concurrency control as a way to help prevent simultaneous updates of a policy from overwriting each other. It is strongly suggested that systems make use of the `etag` in the read-modify-write cycle to perform policy updates in order to avoid race conditions: An `etag` is returned in the response to `getIamPolicy`, and systems are expected to put that etag in the request to `setIamPolicy` to ensure that their change will be applied to the same version of the policy. **Important:** If you use IAM Conditions, you must include the `etag` field whenever you call `setIamPolicy`. If you omit this field, then IAM allows you to overwrite a version `3` policy with a version `1` policy, and all of the conditions in the version `3` policy are lost.
    string etag?;
    # Specifies the format of the policy. Valid values are `0`, `1`, and `3`. Requests that specify an invalid value are rejected. Any operation that affects conditional role bindings must specify version `3`. This requirement applies to the following operations: * Getting a policy that includes a conditional role binding * Adding a conditional role binding to a policy * Changing a conditional role binding in a policy * Removing any role binding, with or without a condition, from a policy that includes conditions **Important:** If you use IAM Conditions, you must include the `etag` field whenever you call `setIamPolicy`. If you omit this field, then IAM allows you to overwrite a version `3` policy with a version `1` policy, and all of the conditions in the version `3` policy are lost. If a policy does not include any conditions, operations on that policy may specify any valid version or leave the field unset. To learn which resources support conditions in their IAM policies, see the [IAM documentation](https://cloud.google.com/iam/help/conditions/resource-policies).
    int 'version?;
};

# Represents the category hierarchy of a SKU.
public type Category record {
    # The type of product the SKU refers to. Example: "Compute", "Storage", "Network", "ApplicationServices" etc.
    string resourceFamily?;
    # A group classification for related SKUs. Example: "RAM", "GPU", "Prediction", "Ops", "GoogleEgress" etc.
    string resourceGroup?;
    # The display name of the service this SKU belongs to.
    string serviceDisplayName?;
    # Represents how the SKU is consumed. Example: "OnDemand", "Preemptible", "Commit1Mo", "Commit1Yr" etc.
    string usageType?;
};

# Encapsulates the geographic taxonomy data for a sku.
public type GeoTaxonomy record {
    # The list of regions associated with a sku. Empty for Global skus, which are associated with all Google Cloud regions.
    string[] regions?;
    # The type of Geo Taxonomy: GLOBAL, REGIONAL, or MULTI_REGIONAL.
    string 'type?;
};

# Request message for `SetIamPolicy` method.
public type SetIamPolicyRequest record {
    # An Identity and Access Management (IAM) policy, which specifies access controls for Google Cloud resources. A `Policy` is a collection of `bindings`. A `binding` binds one or more `members` to a single `role`. Members can be user accounts, service accounts, Google groups, and domains (such as G Suite). A `role` is a named list of permissions; each `role` can be an IAM predefined role or a user-created custom role. For some types of Google Cloud resources, a `binding` can also specify a `condition`, which is a logical expression that allows access to a resource only if the expression evaluates to `true`. A condition can add constraints based on attributes of the request, the resource, or both. To learn which resources support conditions in their IAM policies, see the [IAM documentation](https://cloud.google.com/iam/help/conditions/resource-policies). **JSON example:** { "bindings": [ { "role": "roles/resourcemanager.organizationAdmin", "members": [ "user:mike@example.com", "group:admins@example.com", "domain:google.com", "serviceAccount:my-project-id@appspot.gserviceaccount.com" ] }, { "role": "roles/resourcemanager.organizationViewer", "members": [ "user:eve@example.com" ], "condition": { "title": "expirable access", "description": "Does not grant access after Sep 2020", "expression": "request.time < timestamp('2020-10-01T00:00:00.000Z')", } } ], "etag": "BwWWja0YfJA=", "version": 3 } **YAML example:** bindings: - members: - user:mike@example.com - group:admins@example.com - domain:google.com - serviceAccount:my-project-id@appspot.gserviceaccount.com role: roles/resourcemanager.organizationAdmin - members: - user:eve@example.com role: roles/resourcemanager.organizationViewer condition: title: expirable access description: Does not grant access after Sep 2020 expression: request.time < timestamp('2020-10-01T00:00:00.000Z') - etag: BwWWja0YfJA= - version: 3 For a description of IAM and its features, see the [IAM documentation](https://cloud.google.com/iam/docs/).
    Policy policy?;
    # OPTIONAL: A FieldMask specifying which fields of the policy to modify. Only the fields in the mask will be modified. If no mask is provided, the following default mask is used: `paths: "bindings, etag"`
    string updateMask?;
};

# Request message for `TestIamPermissions` method.
public type TestIamPermissionsRequest record {
    # The set of permissions to check for the `resource`. Permissions with wildcards (such as '*' or 'storage.*') are not allowed. For more information see [IAM Overview](https://cloud.google.com/iam/docs/overview#permissions).
    string[] permissions?;
};

# Response message for `ListSkus`.
public type ListSkusResponse record {
    # A token to retrieve the next page of results. To retrieve the next page, call `ListSkus` again with the `page_token` field set to this value. This field is empty if there are no more results to retrieve.
    string nextPageToken?;
    # The list of public SKUs of the given service.
    Sku[] skus?;
};

# Encapsulates a single service in Google Cloud Platform.
public type Service record {
    # The business under which the service is offered. Ex. "businessEntities/GCP", "businessEntities/Maps"
    string businessEntityName?;
    # A human readable display name for this service.
    string displayName?;
    # The resource name for the service. Example: "services/DA34-426B-A397"
    string name?;
    # The identifier for the service. Example: "DA34-426B-A397"
    string serviceId?;
};

# Specifies the audit configuration for a service. The configuration determines which permission types are logged, and what identities, if any, are exempted from logging. An AuditConfig must have one or more AuditLogConfigs. If there are AuditConfigs for both `allServices` and a specific service, the union of the two AuditConfigs is used for that service: the log_types specified in each AuditConfig are enabled, and the exempted_members in each AuditLogConfig are exempted. Example Policy with multiple AuditConfigs: { "audit_configs": [ { "service": "allServices", "audit_log_configs": [ { "log_type": "DATA_READ", "exempted_members": [ "user:jose@example.com" ] }, { "log_type": "DATA_WRITE" }, { "log_type": "ADMIN_READ" } ] }, { "service": "sampleservice.googleapis.com", "audit_log_configs": [ { "log_type": "DATA_READ" }, { "log_type": "DATA_WRITE", "exempted_members": [ "user:aliya@example.com" ] } ] } ] } For sampleservice, this policy enables DATA_READ, DATA_WRITE and ADMIN_READ logging. It also exempts jose@example.com from DATA_READ logging, and aliya@example.com from DATA_WRITE logging.
public type AuditConfig record {
    # The configuration for logging of each type of permission.
    AuditLogConfig[] auditLogConfigs?;
    # Specifies a service that will be enabled for audit logging. For example, `storage.googleapis.com`, `cloudsql.googleapis.com`. `allServices` is a special value that covers all services.
    string 'service?;
};

# Provides the configuration for logging a type of permissions. Example: { "audit_log_configs": [ { "log_type": "DATA_READ", "exempted_members": [ "user:jose@example.com" ] }, { "log_type": "DATA_WRITE" } ] } This enables 'DATA_READ' and 'DATA_WRITE' logging, while exempting jose@example.com from DATA_READ logging.
public type AuditLogConfig record {
    # Specifies the identities that do not cause logging for this type of permission. Follows the same format of Binding.members.
    string[] exemptedMembers?;
    # The log type that this config enables.
    string logType?;
};

# Expresses a mathematical pricing formula. For Example:- `usage_unit: GBy` `tiered_rates:` `[start_usage_amount: 20, unit_price: $10]` `[start_usage_amount: 100, unit_price: $5]` The above expresses a pricing formula where the first 20GB is free, the next 80GB is priced at $10 per GB followed by $5 per GB for additional usage.
public type PricingExpression record {
    # The base unit for the SKU which is the unit used in usage exports. Example: "By"
    string baseUnit?;
    # Conversion factor for converting from price per usage_unit to price per base_unit, and start_usage_amount to start_usage_amount in base_unit. unit_price / base_unit_conversion_factor = price per base_unit. start_usage_amount * base_unit_conversion_factor = start_usage_amount in base_unit.
    decimal baseUnitConversionFactor?;
    # The base unit in human readable form. Example: "byte".
    string baseUnitDescription?;
    # The recommended quantity of units for displaying pricing info. When displaying pricing info it is recommended to display: (unit_price * display_quantity) per display_quantity usage_unit. This field does not affect the pricing formula and is for display purposes only. Example: If the unit_price is "0.0001 USD", the usage_unit is "GB" and the display_quantity is "1000" then the recommended way of displaying the pricing info is "0.10 USD per 1000 GB"
    decimal displayQuantity?;
    # The list of tiered rates for this pricing. The total cost is computed by applying each of the tiered rates on usage. This repeated list is sorted by ascending order of start_usage_amount.
    TierRate[] tieredRates?;
    # The short hand for unit of usage this pricing is specified in. Example: usage_unit of "GiBy" means that usage is specified in "Gibi Byte".
    string usageUnit?;
    # The unit of usage in human readable form. Example: "gibi byte".
    string usageUnitDescription?;
};

# Represents an amount of money with its currency type.
public type Money record {
    # The three-letter currency code defined in ISO 4217.
    string currencyCode?;
    # Number of nano (10^-9) units of the amount. The value must be between -999,999,999 and +999,999,999 inclusive. If `units` is positive, `nanos` must be positive or zero. If `units` is zero, `nanos` can be positive, zero, or negative. If `units` is negative, `nanos` must be negative or zero. For example $-1.75 is represented as `units`=-1 and `nanos`=-750,000,000.
    int nanos?;
    # The whole units of the amount. For example if `currencyCode` is `"USD"`, then 1 unit is one US dollar.
    string units?;
};

# Represents a textual expression in the Common Expression Language (CEL) syntax. CEL is a C-like expression language. The syntax and semantics of CEL are documented at https://github.com/google/cel-spec. Example (Comparison): title: "Summary size limit" description: "Determines if a summary is less than 100 chars" expression: "document.summary.size() < 100" Example (Equality): title: "Requestor is owner" description: "Determines if requestor is the document owner" expression: "document.owner == request.auth.claims.email" Example (Logic): title: "Public documents" description: "Determine whether the document should be publicly visible" expression: "document.type != 'private' && document.type != 'internal'" Example (Data Manipulation): title: "Notification string" description: "Create a notification string with a timestamp." expression: "'New message received at ' + string(document.create_time)" The exact variables and functions that may be referenced within an expression are determined by the service that evaluates it. See the service documentation for additional information.
public type Expr record {
    # Optional. Description of the expression. This is a longer text which describes the expression, e.g. when hovered over it in a UI.
    string description?;
    # Textual representation of an expression in Common Expression Language syntax.
    string expression?;
    # Optional. String indicating the location of the expression for error reporting, e.g. a file name and a position in the file.
    string location?;
    # Optional. Title for the expression, i.e. a short string describing its purpose. This can be used e.g. in UIs which allow to enter the expression.
    string title?;
};

# Encapsulation of billing information for a Google Cloud Console project. A project has at most one associated billing account at a time (but a billing account can be assigned to multiple projects).
public type ProjectBillingInfo record {
    # The resource name of the billing account associated with the project, if any. For example, `billingAccounts/012345-567890-ABCDEF`.
    string billingAccountName?;
    # True if the project is associated with an open billing account, to which usage on the project is charged. False if the project is associated with a closed billing account, or no billing account at all, and therefore cannot use paid services. This field is read-only.
    boolean billingEnabled?;
    # The resource name for the `ProjectBillingInfo`; has the form `projects/{project_id}/billingInfo`. For example, the resource name for the billing information for project `tokyo-rain-123` would be `projects/tokyo-rain-123/billingInfo`. This field is read-only.
    string name?;
    # The ID of the project that this `ProjectBillingInfo` represents, such as `tokyo-rain-123`. This is a convenience field so that you don't need to parse the `name` field to obtain a project ID. This field is read-only.
    string projectId?;
};

# Response message for `TestIamPermissions` method.
public type TestIamPermissionsResponse record {
    # A subset of `TestPermissionsRequest.permissions` that the caller is allowed.
    string[] permissions?;
};

# The price rate indicating starting usage and its corresponding price.
public type TierRate record {
    # Usage is priced at this rate only after this amount. Example: start_usage_amount of 10 indicates that the usage will be priced at the unit_price after the first 10 usage_units.
    decimal startUsageAmount?;
    # Represents an amount of money with its currency type.
    Money unitPrice?;
};

# A billing account in the [Google Cloud Console](https://console.cloud.google.com/). You can assign a billing account to one or more projects.
public type BillingAccount record {
    # The display name given to the billing account, such as `My Billing Account`. This name is displayed in the Google Cloud Console.
    string displayName?;
    # If this account is a [subaccount](https://cloud.google.com/billing/docs/concepts), then this will be the resource name of the parent billing account that it is being resold through. Otherwise this will be empty.
    string masterBillingAccount?;
    # Output only. The resource name of the billing account. The resource name has the form `billingAccounts/{billing_account_id}`. For example, `billingAccounts/012345-567890-ABCDEF` would be the resource name for billing account `012345-567890-ABCDEF`.
    string name?;
    # Output only. True if the billing account is open, and will therefore be charged for any usage on associated projects. False if the billing account is closed, and therefore projects associated with it will be unable to use paid services.
    boolean open?;
};

# Response message for `ListServices`.
public type ListServicesResponse record {
    # A token to retrieve the next page of results. To retrieve the next page, call `ListServices` again with the `page_token` field set to this value. This field is empty if there are no more results to retrieve.
    string nextPageToken?;
    # A list of services.
    Service[] services?;
};

# Represents the pricing information for a SKU at a single point of time.
public type PricingInfo record {
    # Represents the aggregation level and interval for pricing of a single SKU.
    AggregationInfo aggregationInfo?;
    # Conversion rate used for currency conversion, from USD to the currency specified in the request. This includes any surcharge collected for billing in non USD currency. If a currency is not specified in the request this defaults to 1.0. Example: USD * currency_conversion_rate = JPY
    decimal currencyConversionRate?;
    # The timestamp from which this pricing was effective within the requested time range. This is guaranteed to be greater than or equal to the start_time field in the request and less than the end_time field in the request. If a time range was not specified in the request this field will be equivalent to a time within the last 12 hours, indicating the latest pricing info.
    string effectiveTime?;
    # Expresses a mathematical pricing formula. For Example:- `usage_unit: GBy` `tiered_rates:` `[start_usage_amount: 20, unit_price: $10]` `[start_usage_amount: 100, unit_price: $5]` The above expresses a pricing formula where the first 20GB is free, the next 80GB is priced at $10 per GB followed by $5 per GB for additional usage.
    PricingExpression pricingExpression?;
    # An optional human readable summary of the pricing information, has a maximum length of 256 characters.
    string summary?;
};

# Represents the aggregation level and interval for pricing of a single SKU.
public type AggregationInfo record {
    # The number of intervals to aggregate over. Example: If aggregation_level is "DAILY" and aggregation_count is 14, aggregation will be over 14 days.
    int aggregationCount?;
    # The aggregation of interval to aggregate over.
    string aggregationInterval?;
    # The aggregation level to aggregate over.
    string aggregationLevel?;
};

# Encapsulates a single SKU in Google Cloud Platform
public type Sku record {
    # Represents the category hierarchy of a SKU.
    Category category?;
    # A human readable description of the SKU, has a maximum length of 256 characters.
    string description?;
    # Encapsulates the geographic taxonomy data for a sku.
    GeoTaxonomy geoTaxonomy?;
    # The resource name for the SKU. Example: "services/DA34-426B-A397/skus/AA95-CD31-42FE"
    string name?;
    # A timeline of pricing info for this SKU in chronological order.
    PricingInfo[] pricingInfo?;
    # Identifies the service provider. This is 'Google' for first party services in Google Cloud Platform.
    string serviceProviderName?;
    # List of service regions this SKU is offered at. Example: "asia-east1" Service regions can be found at https://cloud.google.com/about/locations/
    string[] serviceRegions?;
    # The identifier for the SKU. Example: "AA95-CD31-42FE"
    string skuId?;
};

# Response message for `ListBillingAccounts`.
public type ListBillingAccountsResponse record {
    # A list of billing accounts.
    BillingAccount[] billingAccounts?;
    # A token to retrieve the next page of results. To retrieve the next page, call `ListBillingAccounts` again with the `page_token` field set to this value. This field is empty if there are no more results to retrieve.
    string nextPageToken?;
};

# Request message for `ListProjectBillingInfoResponse`.
public type ListProjectBillingInfoResponse record {
    # A token to retrieve the next page of results. To retrieve the next page, call `ListProjectBillingInfo` again with the `page_token` field set to this value. This field is empty if there are no more results to retrieve.
    string nextPageToken?;
    # A list of `ProjectBillingInfo` resources representing the projects associated with the billing account.
    ProjectBillingInfo[] projectBillingInfo?;
};
