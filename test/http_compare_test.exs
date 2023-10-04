defmodule HttpCompareTest do
  use ExUnit.Case

  alias HttpCompare
# TEST 1
  describe "compare/2" do
    test "compare two identical JSON strings" do
      json1 = """
      [
        {
          "request": {
            "url": "http://example.com",
            "method": "GET",
            "headers": [{"name": "Header1", "value": "Value1"}]
          },
          "response": {
            "status_code": 200,
            "status_text": "OK",
            "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}]
          }
        }
      ]
      """

      comparison_result = HttpCompare.compare(json1, json1)


      assert comparison_result == [
        %{
          method: {:same, "GET"},
          header_order: :same_order,
          overall_order: :same_order,
          request_headers: [added_headers: [], removed_headers: [], value_changes: []],
          response_headers: [added_headers: [], removed_headers: [], value_changes: []],
          status_code: {:same, 200},
          status_text: {:same, "OK"},
          url: {:same, "http://example.com"}
        }
      ]

    end
  end


# TEST 2
  describe "compare/3" do
    test "compare two JSON strings with different orders of request/response" do
      json1 = """
      [
        {
          "request": {
            "url": "http://example.com",
            "method": "GET",
            "headers": [{"name": "Header1", "value": "Value1"}]
          },
          "response": {
            "status_code": 200,
            "status_text": "OK",
            "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}]
          }
        },
        {
          "request": {
            "url": "http://example2.com",
            "method": "POST",
            "headers": [{"name": "Header1", "value": "Value1"}]
          },
          "response": {
            "status_code": 200,
            "status_text": "OK",
            "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}]
          }
        }
      ]
      """

      json2 = """
      [
        {
          "request": {
            "url": "http://example2.com",
            "method": "POST",
            "headers": [{"name": "Header1", "value": "Value1"}]
          },
          "response": {
            "status_code": 200,
            "status_text": "OK",
            "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}]
          }
        },
        {
          "request": {
            "url": "http://example.com",
            "method": "GET",
            "headers": [{"name": "Header1", "value": "Value1"}]
          },
          "response": {
            "status_code": 200,
            "status_text": "OK",
            "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}]
          }
        }
      ]
      """

      comparison_result = HttpCompare.compare(json1, json2)


      assert comparison_result == [
        %{
          header_order: :same_order,
          method: {:same, "POST"},
          overall_order: :different_order,
          request_headers: [added_headers: [], removed_headers: [], value_changes: []],
          response_headers: [
            added_headers: [],
            removed_headers: [],
            value_changes: []
          ],
          status_code: {:same, 200},
          status_text: {:same, "OK"},
          url: {:same, "http://example2.com"}
        },
        %{
          header_order: :same_order,
          method: {:same, "GET"},
          overall_order: :different_order,
          request_headers: [added_headers: [], removed_headers: [], value_changes: []],
          response_headers: [
            added_headers: [],
            removed_headers: [],
            value_changes: []
          ],
          status_code: {:same, 200},
          status_text: {:same, "OK"},
          url: {:same, "http://example.com"}
        }
      ]

    end
  end

# TEST 3
  describe "compare/4" do
    test "compare two JSON strings with different orders of request headers" do
      json1 = """
      [
        {
          "request": {
            "url": "http://example.com",
            "method": "GET",
            "headers": [{"name": "Header1", "value": "Value1"}, {"test": "Header2", "value2": "Value2"}]
          },
          "response": {
            "status_code": 200,
            "status_text": "OK",
            "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}]
          }
        },
        {
          "request": {
            "url": "http://example2.com",
            "method": "POST",
            "headers": [{"name": "Header1", "value": "Value1"}, {"test": "Header2", "value2": "Value2"}]
          },
          "response": {
            "status_code": 200,
            "status_text": "OK",
            "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}]
          }
        }
      ]
      """

      json2 = """
      [
        {
          "request": {
            "url": "http://example.com",
            "method": "GET",
            "headers": [{"name": "Header1", "value": "Value1"}, {"test": "Header2", "value2": "Value2"}]
          },
          "response": {
            "status_code": 200,
            "status_text": "OK",
            "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}]
          }
        },
        {
          "request": {
            "url": "http://example2.com",
            "method": "POST",
            "headers": [{"test": "Header2", "value2": "Value2"}, {"name": "Header1", "value": "Value1"}]
          },
          "response": {
            "status_code": 200,
            "status_text": "OK",
            "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}]
          }
        }
      ]
      """

      comparison_result = HttpCompare.compare(json1, json2)


      assert comparison_result == [
        %{
          header_order: :different_order,
          method: {:same, "POST"},
          overall_order: :same_order,
          request_headers: [added_headers: [], removed_headers: [], value_changes: []],
          response_headers: [
            added_headers: [],
            removed_headers: [],
            value_changes: []
          ],
          status_code: {:same, 200},
          status_text: {:same, "OK"},
          url: {:same, "http://example2.com"}
        },
        %{
          header_order: :same_order,
          method: {:same, "GET"},
          overall_order: :same_order,
          request_headers: [added_headers: [], removed_headers: [], value_changes: []],
          response_headers: [
            added_headers: [],
            removed_headers: [],
            value_changes: []
          ],
          status_code: {:same, 200},
          status_text: {:same, "OK"},
          url: {:same, "http://example.com"}
        }
      ]

    end
  end

# TEST 4
  describe "compare/5" do
    test "compare two JSON strings with different values of request headers" do
      json1 = """
      [
        {
          "request": {
            "url": "http://example.com",
            "method": "GET",
            "headers": [{"name": "Header1", "value": "Value1"}, {"test": "Header2", "value2": "Value2"}]
          },
          "response": {
            "status_code": 200,
            "status_text": "OK",
            "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}]
          }
        },
        {
          "request": {
            "url": "http://example2.com",
            "method": "POST",
            "headers": [{"name": "Header1", "value": "Value1"}, {"test": "Header2", "value2": "Value2"}]
          },
          "response": {
            "status_code": 200,
            "status_text": "OK",
            "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}]
          }
        }
      ]
      """

      json2 = """
      [
        {
          "request": {
            "url": "http://example.com",
            "method": "GET",
            "headers": [{"name": "Header1", "value": "New Value"}, {"test": "Header2", "value2": "Value2"}]
          },
          "response": {
            "status_code": 200,
            "status_text": "OK",
            "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}]
          }
        },
        {
          "request": {
            "url": "http://example2.com",
            "method": "POST",
            "headers": [{"name": "Header1", "value": "Value1"}, {"test": "Header2", "value2": "Changed Value"}]
          },
          "response": {
            "status_code": 200,
            "status_text": "OK",
            "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}]
          }
        }
      ]
      """

      comparison_result = HttpCompare.compare(json1, json2)


      assert comparison_result == [
        %{
          header_order: :same_order,
          method: {:same, "POST"},
          overall_order: :same_order,
          request_headers: [added_headers: [], removed_headers: [], value_changes: []],
          response_headers: [
            added_headers: [],
            removed_headers: [],
            value_changes: []
          ],
          status_code: {:same, 200},
          status_text: {:same, "OK"},
          url: {:same, "http://example2.com"}
        },
        %{
          header_order: :same_order,
          method: {:same, "GET"},
          overall_order: :same_order,
          request_headers: [
            added_headers: [],
            removed_headers: [],
            value_changes: [{"Header1", "Value1", "New Value"}]
          ],
          response_headers: [
            added_headers: [],
            removed_headers: [],
            value_changes: []
          ],
          status_code: {:same, 200},
          status_text: {:same, "OK"},
          url: {:same, "http://example.com"}
        }
      ]

    end
  end
# TEST 5
  describe "compare/6" do
    test "compare two JSON strings with different orders of response headers" do
      json1 = """
      [
        {
          "request": {
            "url": "http://example.com",
            "method": "GET",
            "headers": [{"name": "Header1", "value": "Value1"}]
          },
          "response": {
            "status_code": 200,
            "status_text": "OK",
            "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}, {"name2": "ResponseHeader1", "value2": "ResponseValue1"}]
          }
        }
      ]
      """

      json2 = """
      [
        {
          "request": {
            "url": "http://example.com",
            "method": "GET",
            "headers": [{"name": "Header1", "value": "Value1"}]
          },
          "response": {
            "status_code": 200,
            "status_text": "OK",
            "headers": [{"name2": "ResponseHeader1", "value2": "ResponseValue1"}, {"name": "ResponseHeader1", "value": "ResponseValue1"}]
          }
        }
      ]
      """

      comparison_result = HttpCompare.compare(json1, json2)


      assert comparison_result == [
        %{
          header_order: :different_order,
          method: {:same, "GET"},
          overall_order: :same_order,
          request_headers: [
            added_headers: [],
            removed_headers: [],
            value_changes: []
          ],
          response_headers: [
            added_headers: [],
            removed_headers: [],
            value_changes: []
          ],
          status_code: {:same, 200},
          status_text: {:same, "OK"},
          url: {:same, "http://example.com"}
        }
      ]

    end
  end
# TEST 6
describe "compare/7" do
  test "compare two JSON strings with different values of status codes and status text" do
    json1 = """
    [
      {
        "request": {
          "url": "http://example.com",
          "method": "GET",
          "headers": [{"name": "Header1", "value": "Value1"}]
        },
        "response": {
          "status_code": 200,
          "status_text": "OK",
          "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}, {"name2": "ResponseHeader1", "value2": "ResponseValue1"}]
        }
      }
    ]
    """

    json2 = """
    [
      {
        "request": {
          "url": "http://example.com",
          "method": "GET",
          "headers": [{"name": "Header1", "value": "Value1"}]
        },
        "response": {
          "status_code": 404,
          "status_text": "Not Found",
          "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}, {"name2": "ResponseHeader1", "value2": "ResponseValue1"}]
        }
      }
    ]
    """

    comparison_result = HttpCompare.compare(json1, json2)


    assert comparison_result == [
      %{
        header_order: :same_order,
        method: {:same, "GET"},
        overall_order: :same_order,
        request_headers: [
          added_headers: [],
          removed_headers: [],
          value_changes: []
        ],
        response_headers: [
          added_headers: [],
          removed_headers: [],
          value_changes: []
        ],
        status_code: {:changed, {200, 404}},
        status_text: {:changed, {"OK", "Not Found"}},
        url: {:same, "http://example.com"}
      }
    ]
  end
end
# TEST 7
describe "compare/8" do
  test "compare two JSON strings when a request/response is deleted" do
    json1 = """
    [
      {
        "request": {
          "url": "http://example.com",
          "method": "GET",
          "headers": [{"name": "Header1", "value": "Value1"}]
        },
        "response": {
          "status_code": 200,
          "status_text": "OK",
          "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}, {"name2": "ResponseHeader1", "value2": "ResponseValue1"}]
        }
      },
      {
        "request": {
          "url": "http://example2.com",
          "method": "POST",
          "headers": [{"name": "Header1", "value": "Value1"}]
        },
        "response": {
          "status_code": 200,
          "status_text": "OK",
          "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}, {"name2": "ResponseHeader1", "value2": "ResponseValue1"}]
        }
      }
    ]
    """

    json2 = """
    [
      {
        "request": {
          "url": "http://example.com",
          "method": "GET",
          "headers": [{"name": "Header1", "value": "Value1"}]
        },
        "response": {
          "status_code": 200,
          "status_text": "OK",
          "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}, {"name2": "ResponseHeader1", "value2": "ResponseValue1"}]
        }
      }
    ]
    """

    comparison_result = HttpCompare.compare(json1, json2)


    assert comparison_result == [
      {:request_removed,
       %{
         "request" => %{
           "headers" => [%{"name" => "Header1", "value" => "Value1"}],
           "method" => "POST",
           "url" => "http://example2.com"
         },
         "response" => %{
           "headers" => [
             %{"name" => "ResponseHeader1", "value" => "ResponseValue1"},
             %{"name2" => "ResponseHeader1", "value2" => "ResponseValue1"}
           ],
           "status_code" => 200,
           "status_text" => "OK"
         }
       }},
      %{
        header_order: :same_order,
        method: {:same, "GET"},
        overall_order: :same_order,
        request_headers: [added_headers: [], removed_headers: [], value_changes: []],
        response_headers: [
          added_headers: [],
          removed_headers: [],
          value_changes: []
        ],
        status_code: {:same, 200},
        status_text: {:same, "OK"},
        url: {:same, "http://example.com"}
      }
    ]
  end
end
# TEST 8
describe "compare/9" do
  test "compare two JSON strings when a request/response is added" do
    json1 = """
    [
      {
        "request": {
          "url": "http://example.com",
          "method": "GET",
          "headers": [{"name": "Header1", "value": "Value1"}]
        },
        "response": {
          "status_code": 200,
          "status_text": "OK",
          "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}, {"name2": "ResponseHeader1", "value2": "ResponseValue1"}]
        }
      }
    ]
    """

    json2 = """
    [
      {
        "request": {
          "url": "http://example.com",
          "method": "GET",
          "headers": [{"name": "Header1", "value": "Value1"}]
        },
        "response": {
          "status_code": 200,
          "status_text": "OK",
          "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}, {"name2": "ResponseHeader1", "value2": "ResponseValue1"}]
        }
      },
      {
        "request": {
          "url": "http://example2.com",
          "method": "POST",
          "headers": [{"name": "Header1", "value": "Value1"}]
        },
        "response": {
          "status_code": 200,
          "status_text": "OK",
          "headers": [{"name": "ResponseHeader1", "value": "ResponseValue1"}, {"name2": "ResponseHeader1", "value2": "ResponseValue1"}]
        }
      }
    ]
    """

    comparison_result = HttpCompare.compare(json1, json2)


    assert comparison_result == [
      %{
        header_order: :same_order,
        method: {:same, "GET"},
        overall_order: :same_order,
        request_headers: [added_headers: [], removed_headers: [], value_changes: []],
        response_headers: [
          added_headers: [],
          removed_headers: [],
          value_changes: []
        ],
        status_code: {:same, 200},
        status_text: {:same, "OK"},
        url: {:same, "http://example.com"}
      },
      {:request_added,
       %{
         "request" => %{
           "headers" => [%{"name" => "Header1", "value" => "Value1"}],
           "method" => "POST",
           "url" => "http://example2.com"
         },
         "response" => %{
           "headers" => [
             %{"name" => "ResponseHeader1", "value" => "ResponseValue1"},
             %{"name2" => "ResponseHeader1", "value2" => "ResponseValue1"}
           ],
           "status_code" => 200,
           "status_text" => "OK"
         }
       }}
    ]
  end
end
end
