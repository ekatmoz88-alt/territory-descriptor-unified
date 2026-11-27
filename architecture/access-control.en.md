# Access Control

## Allow data export

**Purpose.** The “Allow data export” permission grants a user access to the menu item that starts the database export procedure. The source manual explicitly describes it as permission to access the export menu item. This wording alone does not establish that authorization is independently enforced at every internal export-processing step.

**Related workflow.** Section 3.2 describes export as three sequential stages:

1. identify updated information in database tables; in network mode, access by other users to the table being processed is temporarily restricted;
2. optimize the extracted set to remove duplicate rows;
3. generate the export file; this operation may place a significant load on the local network, while database work remains generally possible.

**Permission scope.**
- access/use the export menu item;
- initiate the export procedure provided by the application.

**Not established by the supplied excerpt.** Separate permissions for selecting tables or data categories, invoking export through an API or command line, viewing other users’ exports, downloading generated files, scheduling exports, approving an export, auditing every processing step, or restricting exports by organizational unit. Do not document these as implemented features without further evidence.

**Administration.** Individual permissions are changed by a user authorized to administer the database, through the user-list interface. The manual states that permission settings are stored in a separate file in the application directory.

**Suggested verification tests.**
- a user without the permission cannot access or use the export menu item; verify the exact UI behavior;
- a user with the permission can initiate an export;
- verify temporary table-access restrictions in network mode;
- verify deduplication and the contents of the generated file;
- verify behavior when update discovery or file generation fails;
- verify that the export file name and record count are written to LOG, as listed in section 4.2.

**Traceability:** user/administrator manual, sections 3.2 “Data export”, 4.1 “Access rights” (“Allow data export”), and 4.2 “Program logs”.
