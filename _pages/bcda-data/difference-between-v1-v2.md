---
layout: api-docs
page_title: "What’s the difference between BCDA V1 and V2?"
seo_title: ""
description: "Overview of the differences between BCDA V1 and V2 and a summary of specific API changes."
in-page-nav: true
sidebar-links: 
  - name: BCDA Data
    url: /bcda-data.html
    
    children:
      - name: Guide to Partially Adjudicated Claims Data
        url: /bcda-data/partially-adjudicated-claims-data.html

      - name: Comparison of BCDA and CCLF
        url: /bcda-data/comparison-bcda-cclf-files.html

      - name: Difference Between V1 and V2
        url: /bcda-data/difference-between-v1-v2.html
---

# {{ page.page_title }}

<p>
    BCDA V1 (<a href="https://hl7.org/fhir/STU3/" target="_blank" rel="noopener noreferrer">STU3</a>) and V2 (<a href="https://hl7.org/fhir/R4/" target="_blank" rel="noopener noreferrer">R4</a>) differ primarily in their FHIR specification. Version 1 is based on the Blue Button 2.0 Implementation Guide, while version 2 is based on the <a href="https://www.hl7.org/fhir/us/carin-bb/StructureDefinition-C4BB-ExplanationOfBenefit.html" target="_blank" rel="noopener noreferrer">CARIN CDPDE Implementation Guide</a>.
</p>
<p>There are minor differences in the mapping and values of certain data elements. Slicing/discriminator rules can be different, and some value sets will be bound to CARIN or HL7 value sets instead of BlueButton:
        <ul>
            <li>Example 1: Patient.identifier.type in V2 is bound to the <a href="http://www.hl7.org/fhir/us/carin-bb/ValueSet-C4BBPatientIdentifierType.html" target="_blank" rel="noopener noreferrer">C4BB Patient Identifier type value set</a>.</li>
            <li>Example 2: EOB.Type is bound to the <a href="http://www.hl7.org/fhir/us/carin-bb/ValueSet-C4BBPayeeType.html" target="_blank" rel="noopener noreferrer">C4BB Payee Type value set</a> and the associated value will be one of the codes in that value set.</li>
        </ul>
</p>
<h2>Summary of changes</h2>
<p>
    Reference the R3 Diff in the <a href="http://www.hl7.org/fhir/explanationofbenefit.html#resource" target="_blank" rel="noopener noreferrer">FHIR ExplanationofBenefit</a> for more details.
</p>
<!-- start ol for tables -->
<ol>
    <li>
        <h3 class="font-sans-md">ExplanationOfBenefit (EOB)</h3>
        <!-- table 1 -->
        <table class="usa-table usa-table--borderless usa-table--stacked">
            <caption class="usa-sr-only">Changes to ExplanationOfBenefit (EOB)</caption>
            <thead>
                <tr>
                    <th scope="col">Change type</th>
                    <th scope="col">Description</th>
                    <th scope="col">Examples</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        Consolidated/removed elements
                    </td>
                    <td>
                        Some elements were consolidated and/or removed. For instance, in STU3 there were 2 elements (Eob.Organization and Eob.Provider) that could represent the party responsible for the claim. In R4, this has been consolidated into 1 element (Eob.provider).
                    </td>
                    <td>
                        <ul>
                            <li>Eob.provider</li>
                            <li>Eob.hospitalization</li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td>
                        Added constraints
                    </td>
                    <td>
                        Fifteen fields were changed from optional to mandatory. Changing the optionality in this context generally has no impact on users consuming this data. A few minor constraints were added or modified (e.g., value set bindings and reference targets).
                    </td>
                    <td>
                        <ul>
                            <li>Eob.use</li>
                            <li>Eob.patient</li>
                            <li>Eob.referral</li>
                            <li>Eob.outcome</li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td>
                        New elements
                    </td>
                    <td>
                        Approximately 35 elements were added to the EOB resource type. About 65% of these are child elements of the .addItem property, which isn’t supplied by BCDA. Of the remaining 35%, few are populated by BCDA.
                    </td>
                    <td>
                        <ul>
                            <li>Eob.priority</li>
                            <li>Eob.preAuthRef</li>
                            <li>Eob.diagnosis.onAdmission</li>
                            <li>Eob.formCode</li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td>
                        Renamed elements
                    </td>
                    <td>
                        Four elements were renamed. For users converting to V2, it’s likely that existing parsing or handling logic needs to be adjusted.
                    </td>
                    <td>
                        <ul>
                            <li>Eob.information → Eob.SupportingInfo</li>
                            <li>Eob.careTeamLinkId → Eob.careTeamSequence</li>
                            <li>Eob.diagnosisLinkId → Eob.diagnosisSequence</li>
                            <li>Eob.service → Eob.productOrService</li>
                        </ul>
                    </td>
                </tr>
            </tbody>
        </table>
    </li>
    <li>
        <h3 class="font-sans-md">Patient</h3>
        <p>The Patient resource type is normative with a maturity level of 5, so there are  minimal changes.</p>
    
        <table class="usa-table usa-table--borderless usa-table--stacked">
            <thead>
                <tr>
                    <th scope="col">Change type</th>
                    <th scope="col">Description</th>
                    <th scope="col">Examples</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        Consolidated/removed elements
                    </td>
                    <td>
                        Only 1 element was removed (Patient.animal), which has no effect on BCDA.                
                    </td>
                    <td>
                        <ul>
                            <li>Patient.animal</li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td>
                        Constraints
                    </td>
                    <td>
                        A handful of fields are bound to different value sets. Other minor changes were made  to the default value and reference target.
                    </td>
                    <td>
                        <ul>
                            <li>Patient.active</li>
                            <li>Patient.gender</li>
                            <li>Patient.generalPractitioner</li>
                        </ul>
                    </td>
                </tr>
            </tbody>
        </table>
    </li>
    
    <li>
        <h3 class="font-sans-md">Coverage</h3>
        <!-- table 3 -->
        <table class="usa-table usa-table--borderless usa-table--stacked">
            <thead>
                <tr>
                    <th scope="col">Change type</th>
                    <th scope="col">Description</th>
                    <th scope="col">Examples</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        New elements
                    </td>
                    <td>
                        Six elements were added to the Coverage resource type. Most of these relate to costToBeneficiary and won’t be supplied in BCDA.                
                    </td>
                     <td>
                        <ul>
                            <li>Coverage.class.name</li>
                            <li>Coverage.costToBeneficiary</li>
                            <li>Coverage.costToBeneficiary.type</li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td>
                        Consolidated/removed elements
                    </td>
                    <td>
                        The Coverage.grouping element was removed. The equivalent element in R4 is Coverage.class. This element is provided in the API, so any user converting from V1 to V2 needs to make minor changes to their parsing or handling logic.
                    </td>
                     <td>
                        <ul>
                            <li>Coverage.grouping</li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td>
                        Added constraints
                    </td>
                    <td>
                        A few changes were made to certain mandatory elements. Generally this has little to no impact on users.
                    </td>
                     <td>
                        <ul>
                            <li>Coverage.beneficiary</li>
                            <li>Coverage.payor</li>
                        </ul>
                    </td>
                </tr>
            </tbody>
        </table>
    </li>
</ol>