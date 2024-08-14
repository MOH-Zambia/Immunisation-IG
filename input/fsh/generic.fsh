Profile: ImmunizationPatient
Parent: Patient
Id: immunization-patient
Title: "Generic Patient Profile for Immunizations"
Description: "Is used to document demographics and other administrative information about an individual receiving care or other health-related services."
* identifier 1..*
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.ordered = false
* identifier ^slicing.description = "Slice based on the type of identifier."
* identifier contains
    NRC 0..1 MS

* identifier[NRC] ^definition =
    "reason(s) why this should be supported."
* identifier[NRC].value 1..1
  * obeys NRC-SmartcareID-1
* identifier[NRC].system 1..1
* identifier[NRC].system = "http://openhie.org/fhir/zambia-immunizations/identifier/patient-nrc"

* name 1..*
  * obeys PatientName-Smartcare-1 and PatientName-Smartcare-2
* name.given 0..* MS
* name.given ^definition =
    "reason(s) why this should be supported."
* name.family 0..1 MS
* name.family ^definition =
    "reason(s) why this should be supported."
* name.use 1..1
* name.text 0..1 MS
* name.text ^definition =
    "Used to capture the patient's nickname."

* birthDate 1..1

* address.district 0..1 MS
* address.district ^definition =
    "reason(s) why this should be supported."

* extension contains AdministrativeSex named sex 1..1

* maritalStatus 0..1 MS
* maritalStatus ^definition =
    "reason(s) why this should be supported."
* link 0..* MS
* link ^definition =
    "reason(s) why this should be supported."
* link.other 1..1
* link.type = #seealso

* managingOrganization 0..1 MS
* managingOrganization ^definition =
    "reason(s) why this should be supported."
* managingOrganization only Reference(ServiceProvider)

Profile: ServiceProvider
Parent: Organization
Id: healthcare-service-provider
Title: "Healthcare Service Provider Profile"
Description: "An organization that provides healthcare services."
* identifier 0..*
* identifier ^definition =
  "reason(s) why this should be supported."
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.ordered = false
* identifier ^slicing.description = "Slice based on the type of identifier."
* identifier contains
    XX 0..1
* identifier[XX].value 1..1
* identifier[XX].system = "http://openhie.org/fhir/zambia-immunizations/identifier/healthcare-service-provider"
* identifier[XX].type.coding.code = #XX
* identifier[XX].type.coding.system = "http://terminology.hl7.org/CodeSystem/v2-0203"
* identifier[XX].type.text = "Healthcare service provider identifier"
* type 1..1
* type = $LNC#78022-1
* name 1..1

Profile: RelationToPatient
Parent: RelatedPerson
Id: relation-to-patient
Title: "Relation to Patient Profile"
Description: "This profile acts as a base profile from which more specific RelatedPerson profiles can be derived."
* identifier 0..* MS
* identifier ^definition =
    "reason(s) why this should be supported."
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.ordered = false
* identifier ^slicing.description = "Slice based on the type of identifier."
* identifier contains
    NRC 0..1 MS

* identifier[NRC] ^definition =
    "reason(s) why this should be supported."
* identifier[NRC].value 1..1
  * obeys NRC-SmartcareID-1
* identifier[NRC].system 1..1
* identifier[NRC].system = "http://openhie.org/fhir/zambia-immunizations/identifier/relative-nrc"

* patient 1..1
* name 0..* MS
* name ^definition =
    "reason(s) why this should be supported."
* name.given 0..1 MS
* name.given ^definition =
    "reason(s) why this should be supported."
* name.family 0..1 MS
* name.family ^definition =
    "reason(s) why this should be supported."
* name.use 1..1

* telecom 0..*
* telecom ^slicing.discriminator.type = #value
* telecom ^slicing.discriminator.path = "system"
* telecom ^slicing.rules = #open
* telecom ^slicing.ordered = false
* telecom ^slicing.description = "Slice based on the type of telecom."
* telecom contains
    phone 0..1 MS

* telecom[phone] ^definition =
    "reason(s) why this should be supported."
* telecom[phone].value 1..1
  * obeys PHONE-1
* telecom[phone].system 1..1
* telecom[phone].system = #phone

Profile: GuardianRelatedPerson
Parent: RelationToPatient
Id: guardian-relation-to-patient
Title: "Guardian Relation to Patient Profile"
Description: "A guardian to the patient."
* relationship 1..1
* relationship = $PARENT_RELATIONSHIP_CODES#GUARD
* name.given 1..1
* name.family 1..1
* patient only Reference(SmartcareImmunizationPatient or HPVImmunizationPatient or CovaxImmunizationPatient)

Profile: TargetFacilityEncounter
Parent: Encounter
Id: target-facility-encounter
Title: "Target Facility Encounter" 
Description: "Represents the current facility at which the patient is receiving health services."
* status 1..1
* class 1..1
* class.coding.code = #AMB
* class.coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* subject 1..1
* subject only Reference(SmartcareImmunizationPatient or HPVImmunizationPatient or CovaxImmunizationPatient)
* actualPeriod 1..1
* serviceProvider 0..1 MS
* serviceProvider only Reference(ServiceProvider)
* serviceProvider ^definition =
  "reason(s) why this should be supported."

Profile: GenericObservation
Parent: Observation
Id: generic-social-history-observation-profile
Title: "Generic Observation Profile"
Description: "This profile acts as a base profile from which more observation profiles can be derived."
* status 1..1
* code 1..1
* category 1..1
* encounter 1..1
* encounter only Reference(TargetFacilityEncounter)
* subject 1..1
* subject only Reference(SmartcareImmunizationPatient or HPVImmunizationPatient or CovaxImmunizationPatient)
* performer 0..*
* performer ^definition =
  "reason(s) why this should be supported."

Profile: Vaccines
Parent: Immunization
Id: vaccine-administration
Title: "Generic Vaccine Administration Profile"
Description: "Records the vaccine administered to the patient."
* status 1..1
* vaccineCode 1..1
* vaccineCode from VSVaccines (extensible)
* patient 1..1
* patient only Reference(SmartcareImmunizationPatient or HPVImmunizationPatient or CovaxImmunizationPatient)
* occurrenceDateTime 1..1
* occurrenceDateTime only dateTime
* encounter 1..1
* encounter only Reference(TargetFacilityEncounter)
* protocolApplied 0..1 MS
* protocolApplied ^definition =
  "reason(s) why this should be supported."
* protocolApplied.doseNumber 1..1
* performer 1..*
* performer.actor 1..1
* performer.actor only Reference(SmartcareVaccinationSiteType or HPVVaccinationSiteType or ServiceProvider)