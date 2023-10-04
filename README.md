# HTTP Comparator

**A tool for Teller Employees used to compare two JSON files containing HTTP requests and respective responses.**
**This program determines the changes, additions, deletions, and orders of the headers, keys, and requests/responses**

## Installation:
- Make sure you have Elixir Installed on your machine
    - **Mac** use Homebrew: `brew install elixir`  or check [Elixir Install for Mac](https://elixir-lang.org/install.html#macos)
    - **Windows** check [Elixir Install for Windows](https://elixir-lang.org/install.html#windows)
- Clone this repository into a dedicated directory on your machine
    - Make sure when running on the command line to `cd [your_directory]`
- Ensure you have the Jason library as it's used for JSON parsing.
    - To install Jason library run `mix deps.get`

## Compile and Run:
- Compile by running `mix escript.build` in your command line (terminal)
- Run the program by running `./http_compare`

## Using the Program:
- The command line will prompt you to enter the file path for JSON 1
    - If Json 1 is in the root directory of your program you can just enter the file name ex: **13.3.7_.json**
- Make sure you are entering the orginal JSON file as JSON 1 and the new or updated JSON in for JSON 2

**Input**
```dotnetcli
This program accepts 2 Json files, it will compare the two
assuming that the first Json entered is the original and the second
Json entered is the one with changes, additions, or deletions
Enter path for JSON 1:
> 13.3.7_.json
Enter path for JSON 2:
> 13.4.0_.json
```

**Output**
```dotnetcli
Comparison Result:
[
  %{
    method: {:same, "POST"},
    order: :different_order,
    request_headers: [
      added_headers: ["x-sectrace"],
      removed_headers: ["Cache-Control"],
      value_changes: [
        {"User-Agent", "TheBankMobile/13.3.7 (iPhone; iOS 16.5)",
         "TheBankMobile/13.4.0 (iPhone; iOS 16.5)"},
        {"Cookie",
         "AppVersion=13.3.7;AppType=iPhone;AI=A3254414;CorrelationId=c7129b04-498b-4fcc-9a3e-940a9ab3caf6;persist__data=TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4gQWxpcXVhbSB2ZWxpdCBzZW0sIGNvbnZhbGxpcyBhdCBudW5jIGVnZXN0YXMsIHVsdHJpY2llcyB2dWxwdXRhdGUgbmVxdWUuIE51bGxhIHRlbXB1cyBpYWN1bGlzIHBvc3VlcmU=;",
         "AppVersion=13.4.0;AppType=iPhone;AI=A3254415;CorrelationId=c7129b04-498b-4fcc-9a3e-940a9ab3caf6;persist__data=TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGGFkaXBpc2NpbmcgZWxpdC4gQWxpcXVhbSB2ZWxpdCBzZW0sIGNvbnZhbGxpcyBhdCBudW5jIGVnZXN0YXMsIHVsdHJpY2llcyB2dWxwdXRhdGUgbmVxdWUuIE5N1bGlzIHBvc3VlcmU=;"}
      ]
    ],
    response_headers: [
      added_headers: [],
      removed_headers: ["Date"],
      value_changes: []
    ],
    status_code: {:same, 403},
    status_text: {:same, "Forbidden"},
    url: {:same,
     "https://thebank.teller.engineering/api/accesstokens/usernameandpassword"}
  },
  {:request_removed,
   %{
     "http_version" => "HTTP/1.1",
     "request" => %{
       "body" => nil,
       "headers" => [
         %{"name" => "Host", "value" => "thebank.teller.engineering"},
         %{"name" => "Content-Type", "value" => "application/json"},
         %{"name" => "Accept", "value" => "application/json"},
         %{"name" => "Connection", "value" => "keep-alive"},
         %{
           "name" => "Cookie",
           "value" => "AppVersion=13.3.7;AppType=iPhone;AI=A3254414;"
         },
         %{
           "name" => "User-Agent",
           "value" => "TheBankMobile/13.3.7 (iPhone; iOS 16.5)"
         },
         %{"name" => "Accept-Language", "value" => "en-US;q=1"},
         %{"name" => "Cache-Control", "value" => "no-cache"},
         %{"name" => "Accept-Encoding", "value" => "gzip, deflate, br"}
       ],
       "method" => "GET",
       "url" => "https://thebank.teller.engineering/api/apps/A3254414/configuration?osVersion=16.5appType=iPhone&appVersion=13.3.7"
     },
     "response" => %{
       "body" => "{\"appId\":\"A3254414\",\"appName\":\"The Bank Mobile\",\"properties\":{\"balanceEnablement\":\"Enabled\",\"showAccountNumberEnablement\":\"Enabled\",\"faceIdAuthEnablement\":\"Enabled\",\"billingAndPaymentsEnablement\":\"Disabled\",\"chatEnablement\":\"Disabled\",\"zelleEnablement\":\"Enabled\",\"rewardsEnablement\":\"Disabled\",\"sessionTimeout\":660}}",
       "headers" => [
         %{"name" => "Cache-Control", "value" => "no-store, max-age=0"},
         %{"name" => "Pragma", "value" => "no-cache"},
         %{
           "name" => "Content-Type",
           "value" => "application/json; charset=utf-8"
         },
         %{
           "name" => "Set-Cookie",
           "value" => "CorrelationId=c7129b04-498b-4fcc-9a3e-940a9ab3caf6;HttpOnly;Secure"
         },
         %{"name" => "X-Content-Type-Options", "value" => "nosniff"},
         %{"name" => "X-Frame-Options", "value" => "deny"},
         %{
           "name" => "Strict-Transport-Security",
           "value" => "max-age=31536000; includeSubdomains"
         },
         %{
           "name" => "Content-Security-Policy",
           "value" => "default-src 'self';style-src 'self';script-src 'self'; frame-ancestors 'self'"
         },
         %{"name" => "X-Xss-Protection", "value" => "1; mode=block"},
         %{"name" => "Add-No-Store", "value" => ""},
         %{"name" => "Server-Timing", "value" => "dtSInfo;desc=\"0\""},
         %{"name" => "Date", "value" => "Wed, 09 Aug 2023 10:38:30 GMT"},
         %{"name" => "Content-Length", "value" => "5525"},
         %{
           "name" => "Set-Cookie",
           "value" => "persist__data=TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4gQWxpcXVhbSB2ZWxpdCBzZW0sIGNvbnZhbGxpcyBhdCBudW5jIGVnZXN0YXMsIHVsdHJpY2llcyB2dWxwdXRhdGUgbmVxdWUuIE51bGxhIHRlbXB1cyBpYWN1bGlzIHBvc3VlcmU=; path=/; Httponly; Secure"
         }
       ],
       "status_code" => 200,
       "status_text" => "OK"
     }
   }},
  %{
    method: {:same, "GET"},
    order: :different_order,
    request_headers: [
      added_headers: [],
      removed_headers: [],
      value_changes: [
        {"Accept-Language", "en-US;q=1", "en-US;q=0.8"},
        {"User-Agent", "TheBankMobile/13.3.7 (iPhone; iOS 16.5)",
         "TheBankMobile/13.4.0 (iPhone; iOS 16.5)"}
      ]
    ],
    response_headers: [
      added_headers: [],
      removed_headers: [],
      value_changes: []
    ],
    status_code: {:same, 200},
    status_text: {:same, "OK"},
    url: {:same,
     "https://status.thebank.teller.engineering/status.json?downtimeTimestamp=1691577508.930853"}
  },
  {:request_added,
   %{
     "http_version" => "HTTP/1.1",
     "request" => %{
       "body" => nil,
       "headers" => [
         %{"name" => "Host", "value" => "thebank.teller.engineering"},
         %{"name" => "Cache-Control", "value" => "no-cache"},
         %{"name" => "Content-Type", "value" => "application/json"},
         %{"name" => "Accept", "value" => "application/json"},
         %{
           "name" => "Cookie",
           "value" => "AppVersion=13.4.0;AppType=iPhone;AI=A3254415;"
         },
         %{
           "name" => "User-Agent",
           "value" => "TheBankMobile/13.4.0 (iPhone; iOS 16.5)"
         },
         %{
           "name" => "x-sectrace",
           "value" => "b645a590-b5e3-49c6-9efe-ce774f02de08"
         },
         %{"name" => "Accept-Language", "value" => "en-US;q=1"},
         %{"name" => "Accept-Encoding", "value" => "gzip, deflate, br"},
         %{"name" => "Connection", "value" => "keep-alive"}
       ],
       "method" => "GET",
       "url" => "https://thebank.teller.engineering/api/apps/A3254415/configuration?osVersion=16.5appType=iPhone&appVersion=13.4.0"
     },
     "response" => %{
       "body" => "{\"appId\":\"A3254415\",\"appName\":\"The Bank Mobile\",\"properties\":{\"balanceEnablement\":\"Enabled\",\"showAccountNumberEnablement\":\"Enabled\",\"paymentsEnablement\":\"Disabled\",\"chatEnablement\":\"Disabled\",\"aiEnablement\":\"Disabled\",\"zelleEnablement\":\"Enabled\",\"rewardsEnablement\":\"Disabled\",\"sessionTimeout\":660}}",
       "headers" => [
         %{"name" => "Cache-Control", "value" => "no-store, max-age=0"},
         %{"name" => "Pragma", "value" => "no-cache"},
         %{
           "name" => "Content-Type",
           "value" => "application/json; charset=utf-8"
         },
         %{
           "name" => "Set-Cookie",
           "value" => "CorrelationId=c7129b04-498b-4fcc-9a3e-940a9ab3caf6;HttpOnly;Secure"
         },
         %{"name" => "X-Content-Type-Options", "value" => "nosniff"},
         %{"name" => "X-Frame-Options", "value" => "deny"},
         %{
           "name" => "Strict-Transport-Security",
           "value" => "max-age=31536000; includeSubdomains"
         },
         %{
           "name" => "Content-Security-Policy",
           "value" => "default-src 'self';style-src 'self';script-src 'self'; frame-ancestors 'self'"
         },
         %{"name" => "X-Xss-Protection", "value" => "1; mode=block"},
         %{"name" => "Add-No-Store", "value" => ""},
         %{"name" => "Server-Timing", "value" => "dtSInfo;desc=\"0\""},
         %{"name" => "Date", "value" => "Wed, 09 Aug 2023 10:38:30 GMT"},
         %{"name" => "Content-Length", "value" => "5525"},
         %{
           "name" => "Set-Cookie",
           "value" => "persist__data=TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4gQWxpcXVhbSB2ZWxpdCBzZW0sIGNvbnZhbGxpcyBhdCBudW5jIGVnZXN0YXMsIHVsdHJpY2llcyB2dWxwdXRhdGUgbmVxdWUuIE51bGxhIHRlbXB1cyBpYWN1bGlzIHBvc3VlcmU=; path=/; Httponly; Secure"
         }
       ],
       "status_code" => 200,
       "status_text" => "OK"
     }
   }},
  {:request_added,
   %{
     "http_version" => "HTTP/1.1",
     "request" => %{
       "body" => "dGVsbGVyLWNoYWxsZW5nZQ==",
       "headers" => [
         %{"name" => "Host", "value" => "thebank.teller.engineering"},
         %{"name" => "Cache-Control", "value" => "no-cache"},
         %{"name" => "Content-Type", "value" => "application/json"},
         %{"name" => "Accept", "value" => "application/json"},
         %{
           "name" => "Cookie",
           "value" => "AppVersion=13.4.0;AppType=iPhone;AI=A3254415;"
         },
         %{
           "name" => "User-Agent",
           "value" => "TheBankMobile/13.4.0 (iPhone; iOS 16.5)"
         },
         %{
           "name" => "x-sectrace",
           "value" => "b645a590-b5e3-49c6-9efe-ce774f02de08"
         },
         %{"name" => "Accept-Language", "value" => "en-US;q=1"},
         %{"name" => "Accept-Encoding", "value" => "gzip, deflate, br"},
         %{"name" => "Connection", "value" => "keep-alive"}
       ],
       "method" => "POST",
       "url" => "https://thebank.teller.engineering/api/sectrace/verify"
     },
     "response" => %{
       "body" => "{\"status\":\"accepted\"}",
       "headers" => [
         %{"name" => "Cache-Control", "value" => "no-store, max-age=0"},
         %{"name" => "Pragma", "value" => "no-cache"},
         %{
           "name" => "Content-Type",
           "value" => "application/json; charset=utf-8"
         },
         %{
           "name" => "Set-Cookie",
           "value" => "CorrelationId=c7129b04-498b-4fcc-9a3e-940a9ab3caf6;HttpOnly;Secure"
         },
         %{"name" => "X-Content-Type-Options", "value" => "nosniff"},
         %{"name" => "X-Frame-Options", "value" => "deny"},
         %{
           "name" => "Strict-Transport-Security",
           "value" => "max-age=31536000; includeSubdomains"
         },
         %{
           "name" => "Content-Security-Policy",
           "value" => "default-src 'self';style-src 'self';script-src 'self'; frame-ancestors 'self'"
         },
         %{"name" => "X-Xss-Protection", "value" => "1; mode=block"},
         %{"name" => "Add-No-Store", "value" => ""},
         %{"name" => "Server-Timing", "value" => "dtSInfo;desc=\"0\""},
         %{"name" => "Date", "value" => "Wed, 09 Aug 2023 10:38:30 GMT"},
         %{"name" => "Content-Length", "value" => "5525"},
         %{
           "name" => "Set-Cookie",
           "value" => "persist__data=TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4gQWxpcXVhbSB2ZWxpdCBzZW0sIGNvbnZhbGxpcyBhdCBudW5jIGVnZXN0YXMsIHVsdHJpY2llcyB2dWxwdXRhdGUgbmVxdWUuIE51bGxhIHRlbXB1cyBpYWN1bGlzIHBvc3VlcmU=; path=/; Httponly; Secure"
         }
       ],
       "status_code" => 200,
       "status_text" => "OK"
     }
   }}
]
```

