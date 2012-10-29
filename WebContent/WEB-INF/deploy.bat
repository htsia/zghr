set AXIS_LIB=E:\program\newHR\source\HRD_App\WebContent\WEB-INF\lib

set AXISCLASSPATH=%AXIS_LIB%\mail.jar;%AXIS_LIB%\activation.jar;%AXIS_LIB%\jaxrpc.jar;%AXIS_LIB%\axis.jar;%AXIS_LIB%\commons-discovery-0.2.jar;%AXIS_LIB%\commons-logging-1.1.jar;%AXIS_LIB%\saaj.jar;%AXIS_LIB%\log4j-1.2.8.jar;%AXIS_LIB%\xml-apis.jar;%AXIS_LIB%\xercesImpl.jar

java -cp %AXISCLASSPATH% org.apache.axis.client.AdminClient -lhttp://localhost:8080/services/dataInterFace deploy.wsdd