# a Mixin that include in every test case
import os;
import sys;
import time;

import socket;
import codecs;

import sqlite3;

from selenium import webdriver
from selenium.webdriver.remote.webdriver import WebDriver
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait

#sys.path.insert(0, '../pages')
#from login_page import LoginPage

class TestHelper:

  # A helper function to return webdriver instance
  #  In other languages, take browser type as parameter, but seem no the case for Python
  @classmethod
  def open_browser(cls):
    env_browser = os.environ.get("BROWSER")
    if env_browser == "firefox":
      cls.driver = webdriver.Firefox()
    elif env_browser == "safari":
      cls.driver = webdriver.Safari()
    elif env_browser == "ie":
      cls.driver = webdriver.Ie()
    elif env_browser == "edge":
      cls.driver = webdriver.Edge()
    else:
      cls.driver = webdriver.Chrome(options = cls.browser_chrome_options())
    
    # save driver session for later to attach it, for much easier debugging test steps
    cls.save_driver_session()
    return cls.driver
     
  @classmethod
  def browser_chrome_options(cls):
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_experimental_option("detach", True)
    # chrome_options.add_option("detach", True);
    return chrome_options;

  @classmethod
  def site_url(cls):
    the_site_url = os.environ.get("BASE_URL");
    if not the_site_url:
      the_site_url = "https://travel.agileway.net"
    return the_site_url;

  def wait_for_ajax_complete(self, max_seconds):
    count = 0
    while (count < max_seconds):
      count += 1
      is_ajax_complete = self.driver.execute_script("return window.jQuery != undefined && jQuery.active == 0");
      if is_ajax_complete:
        return
      else:
        time.sleep(1)
    raise Exception("Timed out waiting for AJAX call after %i seconds" % max_seconds)

  @classmethod
  def is_debugging(cls):
    # special case:
    # on Windows, not calling driver.quit hangs execution in TestWise, fine on macOS
    if sys.platform.startswith('win'):
      return False;

    if "RUN_IN_TESTWISE" in os.environ and "TESTWISE_RUNNING_AS" in os.environ:
      return os.environ['RUN_IN_TESTWISE'] == "true" and os.environ["TESTWISE_RUNNING_AS"] == "test_case"
    else:
      return False


  @classmethod
  def get_testwise_db_file(cls):
    if 'TESTWISE_DB_FILE' in os.environ and os.path.exists(os.environ["TESTWISE_DB_FILE"]):
      print(os.environ["TESTWISE_DB_FILE"])
      return  os.environ["TESTWISE_DB_FILE"]
    else:
      return None

  @classmethod
  def save_driver_session(cls):
    executor_url = cls.driver.command_executor._url
    session_id = cls.driver.session_id

    if (len(executor_url) > 5 and len(session_id) > 5):
      print("[SAVE] WDURL: " + executor_url + ", session id: " + session_id);
      # cls.puts("session id: " + session_id + ", WDURL: " + executor_url + "|");
      testwise_db_file = cls.get_testwise_db_file()
      if testwise_db_file:
        conn = sqlite3.connect(testwise_db_file)
        c = conn.cursor()
        c.execute("UPDATE TEST_EXECUTIONS SET WEBDRIVER_SESSION_ID='" + session_id  + "', WEBDRIVER_URL='" + executor_url + "' WHERE  id = (SELECT MAX(id) FROM TEST_EXECUTIONS)")
        conn.commit()
        conn.close()

  @classmethod
  def reuse_current_browser(cls):
    testwise_db_file = cls.get_testwise_db_file()
    if testwise_db_file:
      conn = sqlite3.connect(testwise_db_file)
      cursor = conn.cursor()
      cursor.execute('SELECT WEBDRIVER_SESSION_ID, WEBDRIVER_URL FROM TEST_EXECUTIONS WHERE id = (SELECT MAX(id) FROM TEST_EXECUTIONS)')
      records = cursor.fetchall()
      session_id = records[0][0]
      executor_url = records[0][1]
      conn.close();
      cls.puts("RETRIEVE WDURL: " + executor_url)
      return cls.attach_to_session(executor_url, session_id)
    else:
      return None

  @classmethod
  def attach_to_session(self, executor_url, session_id):
    original_execute = WebDriver.execute
    def new_command_execute(self, command, params=None):
      if command == "newSession":
        # Mock the response
        return {'success': 0, 'value': None, 'sessionId': session_id}
      else:
        return original_execute(self, command, params)
    # Patch the function before creating the driver object
    WebDriver.execute = new_command_execute
    driver = webdriver.Remote(command_executor=executor_url, desired_capabilities={})
    driver.session_id = session_id
    # Replace the patched function with original function
    WebDriver.execute = original_execute
    return driver

  @classmethod
  def puts(cls, message):
    print(message)
    cls.connect_to_testwise("OUTPUT", message)


  @classmethod
  def connect_to_testwise(cls, message_type, body):
    if "TESTWISE_TRACE_PORT" in os.environ:
      testwise_port = int(os.environ["TESTWISE_TRACE_PORT"])
    else:
      testwise_port = 7535
    # print("TESTWISE PORT: " + str(testwise_port))

    if len(body) > 4000:
      body = body[0:4000]

    try:
      with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect(('127.0.0.1', testwise_port))
        the_message = message_type + "|" + body
        encoded_bytes = the_message.encode()
        #encoded_bytes = codecs.encode(the_message[0, len(the_message)-1], 'utf-8')
        #encoded_bytes = codecs.encode(the_message, 'utf-8')
        s.sendall(encoded_bytes[0:len(encoded_bytes)-1])
        # data = s.recv(1024)
    except ConnectionRefusedError:
      print("Unable to connect to TestWise")

  def page_text(self):
    return self.driver.find_element_by_tag_name("body").text;


  ## user defined functions
  # 
  def login(self, username, password):
    self.driver.find_element_by_id("username").send_keys(username)
    self.driver.find_element_by_id("password").send_keys(password)
    self.driver.find_element_by_xpath("//input[@value='Sign in']").click()
