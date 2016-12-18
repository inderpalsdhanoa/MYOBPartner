/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class ComponentController {
    global Boolean isCase {
        get;
        set;
    }
    global String multipleId {
        get;
        set;
    }
    global Id parentID {
        get;
        set;
    }
    global String parentId15 {
        get;
        set;
    }
    global ComponentController() {

    }
    global List<NoteAndAttachment> getNoteAndAttachment() {
        return null;
    }
    global SObject getParentObject() {
        return null;
    }
    global List<CADragNDrop.ComponentController.WrapperClass_latest> getWrapperList() {
        return null;
    }
    global Boolean getisCase1() {
        return null;
    }
global class WrapperClass {
    global Boolean isFile {
        get;
        set;
    }
    global NoteAndAttachment notes {
        get;
        set;
    }
    global WrapperClass(NoteAndAttachment notes) {

    }
}
global class WrapperClass_latest implements System.Comparable {
    global Boolean isCase {
        get;
        set;
    }
    global Boolean isNote {
        get;
        set;
    }
    global Boolean isRunningFromAccount {
        get;
        set;
    }
    global Datetime lastmodifieddate {
        get;
        set;
    }
    global String objectName {
        get;
        set;
    }
    global String ownerId {
        get;
        set;
    }
    global String ownerName {
        get;
        set;
    }
    global String parentId {
        get;
        set;
    }
    global String parentName {
        get;
        set;
    }
    global String recordId {
        get;
        set;
    }
    global String title {
        get;
        set;
    }
    global WrapperClass_latest(Boolean isNote, Boolean isCase, String recordId, String parentName, String parentId, String objectName, String ownername, String ownerid, String title, Datetime lastmodifieddate, Boolean s) {

    }
    global Integer compareTo(Object compareTo) {
        return null;
    }
}
}
