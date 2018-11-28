/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
@RestResource(urlMapping='/dc3Job/*')
global class dc3JobExternal {
    global dc3JobExternal() {

    }
    @HttpDelete
    global static void deleteJob() {

    }
    @HttpGet
    global static void getJobList() {

    }
    @HttpPut
    global static void setJobStatus(Id jobId, String status) {

    }
    @HttpPost
    global static Boolean setResult(dupcheck.dc3JobExternal.ResultInput input) {
        return null;
    }
global class ExternalField {
    global String fieldLabel {
        get;
        set;
    }
    global String fieldName {
        get;
        set;
    }
    global String fieldType {
        get;
        set;
    }
    global ExternalField(String n, String l, String t) {

    }
}
global class ExternalJob {
    global String autoProcess {
        get;
        set;
    }
    global Map<String,String> crossFieldMap {
        get;
        set;
    }
    global String filterType {
        get;
        set;
    }
    global Boolean indexEmailDomain {
        get;
        set;
    }
    global Boolean isCrossObject {
        get;
        set;
    }
    global Boolean isRecordType {
        get;
        set;
    }
    global Id jobId {
        get;
        set;
    }
    global String jobName {
        get;
        set;
    }
    global String match {
        get;
        set;
    }
    global List<dupcheck.dc3JobExternal.ExternalField> matchFields {
        get;
        set;
    }
    global String matchFilter {
        get;
        set;
    }
    global String matchLabel {
        get;
        set;
    }
    global String matchObject {
        get;
        set;
    }
    global String matchQuery {
        get;
        set;
    }
    global Id ownerId {
        get;
        set;
    }
    global String ownerName {
        get;
        set;
    }
    global Map<Id,dupcheck.dc3JobExternal.ExternalRecordTypeConfig> recordTypeConfig {
        get;
        set;
    }
    global List<dupcheck.dc3JobExternal.ExternalScenario> scenarioList {
        get;
        set;
    }
    global String source {
        get;
        set;
    }
    global List<dupcheck.dc3JobExternal.ExternalField> sourceFields {
        get;
        set;
    }
    global String sourceFilter {
        get;
        set;
    }
    global String sourceLabel {
        get;
        set;
    }
    global String sourceObject {
        get;
        set;
    }
    global String sourceQuery {
        get;
        set;
    }
    global Datetime startDate {
        get;
        set;
    }
    global String status {
        get;
        set;
    }
    global String statusLabel {
        get;
        set;
    }
    global ExternalJob() {

    }
}
global class ExternalRecordTypeConfig {
    global Set<Id> matchWith {
        get;
        set;
    }
    global Id recordTypeId {
        get;
        set;
    }
    global Set<Id> scenarios {
        get;
        set;
    }
    global ExternalRecordTypeConfig() {

    }
}
global class ExternalScenario {
    global List<dupcheck.dc3JobExternal.ExternalScenarioField> fieldList {
        get;
        set;
    }
    global String name {
        get;
        set;
    }
    global String scenarioId {
        get;
        set;
    }
    global String scoreMethod {
        get;
        set;
    }
    global Integer threshold {
        get;
        set;
    }
    global ExternalScenario() {

    }
}
global class ExternalScenarioField {
    global String field {
        get;
        set;
    }
    global String frequentList {
        get;
        set;
    }
    global String matchConfig {
        get;
        set;
    }
    global String matchMethod {
        get;
        set;
    }
    global Integer weight {
        get;
        set;
    }
    global ExternalScenarioField() {

    }
}
global class GroupPair {
    global Integer groupNumber;
    global Id matchId;
    global Integer score;
    global Id sourceId;
    global GroupPair() {

    }
}
global class JobListResult {
    global Map<String,Set<String>> frequentWords {
        get;
        set;
    }
    global List<dupcheck.dc3JobExternal.ExternalJob> jobList {
        get;
        set;
    }
    global Integer recordLimit {
        get;
        set;
    }
    global JobListResult() {

    }
    global Blob toBlob() {
        return null;
    }
}
global class ResultInput {
    global Boolean finished;
    global Id jobId;
    global List<dupcheck.dc3JobExternal.GroupPair> result;
    global ResultInput() {

    }
}
}
