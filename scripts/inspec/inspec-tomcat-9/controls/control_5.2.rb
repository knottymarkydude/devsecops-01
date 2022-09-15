   TOMCAT_HOME= attribute(
    'tomcat_home',
    description: 'location of tomcat home directory',
    value: '/usr/local/tomcat'
  )

  TOMCAT_REALMS_LIST= attribute(
    'tomcat_realms_list',
    description: 'A list of Realms that should not be enabled',
    value: ['org.apache.catalina.realm.MemoryRealm',
              'org.apache.catalina.realm.JDBCRealm',
              'org.apache.catalina.realm.UserDatabaseRealm',
              'org.apache.catalina.realm.JAASRealm']
  )
  
  lockoutRealm = "org.apache.catalina.realm.LockOutRealm"

    control "5.2" do
    title "5.2 Use LockOut Realms (Scored)"
    desc  "A LockOut realm wraps around standard realms adding the ability to
  lock a user out after multiple failed logins. Locking out a user after multiple
  failed logins slows down attackers from brute forcing logins. "
    impact 0.5
    tag "ref": "1. http://tomcat.apache.org/tomcat-8.0-doc/realm-howto.html 2.
  http://tomcat.apache.org/tomcat-8.0-doc/config/realm.html"
    tag "severity": "medium"
    tag "cis_id": "5.2"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 2
    tag "audit text": "Perform the following to check to see if a LockOut realm
  is being used:
  # grep 'LockOutRealm' $CATALINA_HOME/conf/server.xml
  "
    tag "fix": "Create a lockout realm wrapping the main realm like the example
  below:
  <Realm className='org.apache.catalina.realm.LockOutRealm'
  failureCount='3' lockOutTime='600' cacheSize='1000'
  cacheRemovalWarningTime='3600'>
  <Realm
  className='org.apache.catalina.realm.DataSourceRealm'
  dataSourceName=... />
  </Realm>
  "
  
 
    describe.one do
      describe xml("#{TOMCAT_HOME}/conf/server.xml") do
        its('Server/Service/Engine/Realm/@className') { should cmp lockoutRealm }
      end
      describe xml("#{TOMCAT_HOME}/conf/server.xml") do
        its('Server/Service/Engine/Realm/Realm/@className') { should cmp lockoutRealm }
      end
      describe xml("#{TOMCAT_HOME}/conf/server.xml") do
        its('Server/Service/Host/Realm/@className') { should cmp lockoutRealm }
      end
      describe xml("#{TOMCAT_HOME}/conf/server.xml") do
        its('Server/Service/Host/Realm/Realm/@className') { should cmp lockoutRealm }
      end
      describe xml("#{TOMCAT_HOME}/conf/server.xml") do
        its('Server/Service/Context/Realm/@className') { should cmp lockoutRealm }
      end
      describe xml("#{TOMCAT_HOME}/conf/server.xml") do
        its('Server/Service/Context/Realm/Realm/@className') { should cmp lockoutRealm }
      end
      describe xml("#{TOMCAT_HOME}/conf/context.xml") do
        its('Context/Realm/@className') { should cmp lockoutRealm }
      end
      describe xml("#{TOMCAT_HOME}/conf/context.xml") do
        its('Context/Realm/Realm/@className') { should cmp lockoutRealm }
      end
    end
  end