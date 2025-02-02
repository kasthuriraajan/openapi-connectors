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

# Provides API key configurations needed when communicating with a remote HTTP endpoint.
public type ApiKeysConfig record {|
    # Represents API Key `Ocp-Apim-Subscription-Key`
    @display {label: "", kind: "password"}
    string ocpApimSubscriptionKey;
    # Represents API Key `subscription-key`
    @display {label: "", kind: "password"}
    string subscriptionKey;
|};

public type LastResponse record {
    # Frequency extracted from the series, zero means no recurrent pattern has been found.
    int period?;
    # Suggested input series points needed for detecting the latest point.
    int suggestedWindow?;
    # Expected value of the latest point.
    float expectedValue?;
    # Upper margin of the latest point. UpperMargin is used to calculate upperBoundary, which equals to expectedValue + (100 - marginScale)*upperMargin. If the value of latest point is between upperBoundary and lowerBoundary, it should be treated as normal value. By adjusting marginScale value, anomaly status of latest point can be changed.
    float upperMargin?;
    # Lower margin of the latest point. LowerMargin is used to calculate lowerBoundary, which equals to expectedValue - (100 - marginScale)*lowerMargin. 
    float lowerMargin?;
    # Anomaly status of the latest point, true means the latest point is an anomaly either in negative direction or positive direction.
    boolean isAnomaly?;
    # Anomaly status in negative direction of the latest point. True means the latest point is an anomaly and its real value is smaller than the expected one.
    boolean isNegativeAnomaly?;
    # Anomaly status in positive direction of the latest point. True means the latest point is an anomaly and its real value is larger than the expected one.
    boolean isPositiveAnomaly?;
};

public type LastDetectResponse record {
    # Frequency extracted from the series, zero means no recurrent pattern has been found.
    int period?;
    # Suggested input series points needed for detecting the latest point.
    int suggestedWindow?;
    # Expected value of the latest point.
    float expectedValue?;
    # Upper margin of the latest point. UpperMargin is used to calculate upperBoundary, which equals to expectedValue + (100 - marginScale)*upperMargin. If the value of latest point is between upperBoundary and lowerBoundary, it should be treated as normal value. By adjusting marginScale value, anomaly status of latest point can be changed.
    float upperMargin?;
    # Lower margin of the latest point. LowerMargin is used to calculate lowerBoundary, which equals to expectedValue - (100 - marginScale)*lowerMargin. 
    float lowerMargin?;
    # Anomaly status of the latest point, true means the latest point is an anomaly either in negative direction or positive direction.
    boolean isAnomaly?;
    # Anomaly status in negative direction of the latest point. True means the latest point is an anomaly and its real value is smaller than the expected one.
    boolean isNegativeAnomaly?;
    # Anomaly status in positive direction of the latest point. True means the latest point is an anomaly and its real value is larger than the expected one.
    boolean isPositiveAnomaly?;
};

public type ChangePointDetectRequest record {
    # Time series data points. Points should be sorted by timestamp in ascending order to match the change point detection result.
    Point[] series;
    # Can only be one of yearly, monthly, weekly, daily, hourly, minutely or secondly. Granularity is used for verify whether input series is valid.
    string granularity;
    # Custom Interval is used to set non-standard time interval, for example, if the series is 5 minutes, request can be set as {"granularity":"minutely", "customInterval":5}.
    int customInterval?;
    # Optional argument, periodic value of a time series. If the value is null or does not present, the API will determine the period automatically.
    int period?;
    # Optional argument, advanced model parameter, a default stableTrendWindow will be used in detection.
    int stableTrendWindow?;
    # Optional argument, advanced model parameter, between 0.0-1.0, the lower the value is, the larger the trend error will be which means less change point will be accepted.
    float threshold?;
};

public type ChangePointDetectResponse record {
    # Frequency extracted from the series, zero means no recurrent pattern has been found.
    int period;
    # isChangePoint contains change point properties for each input point. True means an anomaly either negative or positive has been detected. The index of the array is consistent with the input series.
    boolean[] isChangePoint;
    # the change point confidence of each point
    float[] confidenceScores;
};

public type EntireDetectResponse record {
    # Frequency extracted from the series, zero means no recurrent pattern has been found.
    int period;
    # ExpectedValues contain expected value for each input point. The index of the array is consistent with the input series.
    float[] expectedValues;
    # UpperMargins contain upper margin of each input point. UpperMargin is used to calculate upperBoundary, which equals to expectedValue + (100 - marginScale)*upperMargin. Anomalies in response can be filtered by upperBoundary and lowerBoundary. By adjusting marginScale value, less significant anomalies can be filtered in client side. The index of the array is consistent with the input series.
    float[] upperMargins;
    # LowerMargins contain lower margin of each input point. LowerMargin is used to calculate lowerBoundary, which equals to expectedValue - (100 - marginScale)*lowerMargin. Points between the boundary can be marked as normal ones in client side. The index of the array is consistent with the input series.
    float[] lowerMargins;
    # IsAnomaly contains anomaly properties for each input point. True means an anomaly either negative or positive has been detected. The index of the array is consistent with the input series.
    boolean[] isAnomaly;
    # IsNegativeAnomaly contains anomaly status in negative direction for each input point. True means a negative anomaly has been detected. A negative anomaly means the point is detected as an anomaly and its real value is smaller than the expected one. The index of the array is consistent with the input series.
    boolean[] isNegativeAnomaly;
    # IsPositiveAnomaly contain anomaly status in positive direction for each input point. True means a positive anomaly has been detected. A positive anomaly means the point is detected as an anomaly and its real value is larger than the expected one. The index of the array is consistent with the input series.
    boolean[] isPositiveAnomaly;
};

public type Request record {
    # Time series data points. Points should be sorted by timestamp in ascending order to match the anomaly detection result. If the data is not sorted correctly or there is duplicated timestamp, the API will not work. In such case, an error message will be returned.
    Point[] series;
    # Can only be one of yearly, monthly, weekly, daily, hourly, minutely or secondly. Granularity is used for verify whether input series is valid.
    string granularity;
    # Custom Interval is used to set non-standard time interval, for example, if the series is 5 minutes, request can be set as {"granularity":"minutely", "customInterval":5}.
    int customInterval?;
    # Optional argument, periodic value of a time series. If the value is null or does not present, the API will determine the period automatically.
    int period?;
    # Optional argument, advanced model parameter, max anomaly ratio in a time series.
    float maxAnomalyRatio?;
    # Optional argument, advanced model parameter, between 0-99, the lower the value is, the larger the margin value will be which means less anomalies will be accepted
    int sensitivity?;
};

public type Point record {
    # Timestamp of a data point (ISO8601 format).
    string timestamp;
    # The measurement of that point, should be float.
    float value;
};
