// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
public type ClientConfig record {|
    # Configurations related to client authentication
    http:CredentialsConfig auth;
    # The HTTP version understood by the client
    string httpVersion = "1.1";
    # Configurations related to HTTP/1.x protocol
    http:ClientHttp1Settings http1Settings = {};
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings = {};
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with Redirection
    http:FollowRedirects? followRedirects = ();
    # Configurations associated with request pooling
    http:PoolConfiguration? poolConfig = ();
    # HTTP caching related configurations
    http:CacheConfig cache = {};
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig? circuitBreaker = ();
    # Configurations associated with retrying
    http:RetryConfig? retryConfig = ();
    # Configurations associated with cookies
    http:CookieConfig? cookieConfig = ();
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits = {};
    # SSL/TLS-related options
    http:ClientSecureSocket? secureSocket = ();
|};

# This is a generated connector for [Shipwire Containers API v3.0](https://www.shipwire.com/developers/container/) OpenAPI specification.
# The Container API is used to manage shipping containers and boxes within Shipwire Anywhere warehouses and dropship locations. 
# Use it to create a new container, to update an existing container, or to get information about already created containers.
@display {label: "Shipwire Containers", iconPath: "icon.png"}
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    # The connector initialization requires setting the API credentials. 
    # Create a [Shipwire account](https://www.shipwire.com) and obtain tokens by following [this guide](https://www.shipwire.com/developers/getting-started).
    #
    # + clientConfig - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ClientConfig clientConfig, string serviceUrl = "https://api.shipwire.com/") returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Get containers
    #
    # + isActive - Returns containers that are active or not. Valid options are 1 or 0. 
    # + warehouseIds - Returns all containers that exist in the provided warehouse. Single warehouse's id or comma separated list of warehouse ids. 
    # + warehouseExternalIds - Returns all containers that exist in the provided warehouse. Single warehouse's external id or comma separated list of warehouse external ids. 
    # + 'type - Container type. Valid options are 'box', 'envelope', 'tube', 'pallet' 
    # + return - OK 
    remote isolated function getContainers(int? isActive = (), string? warehouseIds = (), string? warehouseExternalIds = (), string[]? 'type = ()) returns GetContainersResponse|error {
        string resourcePath = string `/api/v3.1/containers`;
        map<anydata> queryParam = {"isActive": isActive, "warehouseIds": warehouseIds, "warehouseExternalIds": warehouseExternalIds, "type": 'type};
        map<Encoding> queryParamEncoding = {"type": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        GetContainersResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a new container
    #
    # + payload - CreateANewContainer request 
    # + return - OK 
    remote isolated function postContainers(CreateANewContainerRequest payload) returns CreateANewContainerResponse|error {
        string resourcePath = string `/api/v3.1/containers`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        CreateANewContainerResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a container
    #
    # + id - The container's id or external id. 
    # + return - OK 
    remote isolated function getContainersById(string id) returns GetAContainerResponse|error {
        string resourcePath = string `/api/v3.1/containers/${id}`;
        GetAContainerResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a container
    #
    # + id - The containers's id or external id. 
    # + payload - UpdateAContainer request 
    # + return - OK 
    remote isolated function putContainersById(string id, UpdateAContainerRequest payload) returns UpdateAContainerResponse|error {
        string resourcePath = string `/api/v3.1/containers/${id}`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        UpdateAContainerResponse response = check self.clientEp->put(resourcePath, request);
        return response;
    }
}
