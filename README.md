HealthBoard - Shared Library
============================

Description
-----------
Funded through the Telemedicine and Advanced Technology Research Center (TATRC) and driven by consultations with the Walter Reed National Military Medical Center (WRNMMC), HealthBoard is a visual dashboard prototype that is designed to improve better patient care through better design. Consisting of two portals—the **Patient Portal** and the **Provider Portal**—HealthBoard is designed to serve both communities through better information.

This repository includes the source for the **Shared Library**, which both the **Patient Portal** and **Provider Portal** must reference in order to run. The Patient and Provider Portals can be found [here](https://github.com/piim/TATRC2-VisualDashboard-Patient) and [here](https://github.com/piim/TATRC2-VisualDashboard-Provider).


Installation Instructions
------------
### Configuration
1. Clone the repo into your workspace by executing `git clone https://github.com/piim/Healthboard-Lib.git`
2. In Flex Builder choose `New > Flex Library Project`
3. Name the project 1Healthboard-Lib1 and browse to the repo under Project Location
4. Click Finish
8. Checkout the [Patient](https://github.com/piim/TATRC2-VisualDashboard-Patient) and/or [Provider](https://github.com/piim/TATRC2-VisualDashboard-Provider) portals

More Information
----------------
The prototype and designs are developed to allow patients (in this case active duty military personnel) the ability to interact with their own personal health information and electronic medical records, and healthcare providers with better access to patients and their decisions. By integrating information design principles HealthBoard provides users with enhanced and streamlined access to information, making it less intimidating and easier to understand the impacts of decisions on health outcomes.

HealthBoard is an Open Source product, designed to enhance and/or complement other existing EMR systems. HealthBoard can be used by EMR developers either completely or in a modular fashion as an enhanced presentation layer (it is currently not connected to any back-end system; all the data displayed is static data read from static XML files). Guidance documents will be included, thereby assisting in the adoption of good design principles by developers easier.

Licensing
---------
HealthBoard was developed by the Parsons Institute for Information Mapping (PIIM) funded through the Telemedicine & Advanced Technology Research Center (TATRC). Its source code is in the Public Domain. OSEHRA is hosting the project and has adopted the Apache 2.0 License for contributions made by community members.

You will find the text of the Apache 2.0 License in the LICENSE File.

Further Details
---------------
- [Project Page](http://piim.newschool.edu/healthboard)
- [Healthboard on OSEHRA](http://www.osehra.org/group/healthboard)
