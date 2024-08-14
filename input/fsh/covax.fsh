Profile: CovaxImmunizationPatient
Parent: ImmunizationPatient
Id: covax-immunization-patient
Title: "COVAX Immunization Patient"
Description: "Patient profile for Covax use case"
* identifier 1..*
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.ordered = false
* identifier ^slicing.description = "Slice based on the type of identifier."
* identifier contains
    cardNumber 0..1 MS and 
    passport 0..1 MS
    
* identifier[cardNumber].system = "http://fhir.moh.gov.zm/fhir/IdentifierSystem/vaccination-card-number"
* identifier[cardNumber].value 1..1

* identifier[passport].type = http://terminology.hl7.org/CodeSystem/v2-0203#PPN (exactly)
* identifier[passport].system = "http://fhir.moh.gov.zm/fhir/IdentifierSystem/passport"
* identifier[passport].value 1..1

Profile: CovaxObservation
Parent: Observation
Id: covax-observation
Title: "COVAX Observation"
Description: "Profile for capturing observations during vaccination"
* code 1..1 MS
* code from CovaxObservations (required)
* subject 1..1 MS
* subject only Reference(CovaxImmunizationPatient)
* status 1..1

Profile: UnderlyingCondition
Parent: Condition
Id: underlying-condition
Title: "Underlying Condition"
Description: "Condition profile for capturing specific underlying conditions"
* code 1..1 MS
* code from UnderlyingConditions (required)
* clinicalStatus 1..1
* category 0..*
* severity 0..1
* subject 1..1 MS 
* subject only Reference(CovaxImmunizationPatient)
* evidence 0..*
* note 0..*

Profile: COVID19VaccineMedication
Parent: Medication
Id: covid19-vaccine-medication
Title: "COVID-19 Vaccine Medication"
Description: "A profile for COVID-19 vaccine medications"
* code 1..1 MS
* code from VSVaccines (required)
* status 1..1 MS
* doseForm 0..1 // Form of the vaccine (e.g., powder, tablets, capsule )
* marketingAuthorizationHolder 0..1
* ingredient 0..*
* ingredient.item 1..1
* batch 0..1
* batch.lotNumber 0..1
* batch.expirationDate 0..1