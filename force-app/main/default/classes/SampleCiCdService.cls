/**
 * @description Small service class used to demonstrate CI/CD code coverage. 09-29 09:00 PM
 * Every method has multiple branches, all exercised by SampleCiCdTest.
 */
public with sharing class SampleCiCdService {

    /**
     * @description Adds two integers. Returns 0 if either input is null.
     */
    public static Integer add(Integer a, Integer b) {
        if (a == null || b == null) {
            return 0;
        }
        return a + b;
    }

    /**
     * @description Classifies an integer as UNKNOWN, NEGATIVE, ZERO or POSITIVE.
     */
    public static String classifyNumber(Integer value) {
        if (value == null) {
            return 'UNKNOWN';
        } else if (value < 0) {
            return 'NEGATIVE';
        } else if (value == 0) {
            return 'ZERO';
        }
        return 'POSITIVE';
    }

    /**
     * @description Builds a greeting. Blank names become "Guest".
     */
    public static String formatGreeting(String name) {
        if (String.isBlank(name)) {
            return 'Hello, Guest!';
        }
        return 'Hello, ' + name.trim() + '!';
    }

    /**
     * @description Inserts one Account per non-blank name (bulk safe: a single DML).
     */
    public static List<Account> createAccounts(List<String> names) {
        List<Account> accounts = new List<Account>();
        if (names == null || names.isEmpty()) {
            return accounts;
        }
        for (String accountName : names) {
            if (String.isNotBlank(accountName)) {
                accounts.add(new Account(Name = accountName.trim()));
            }
        }
        if (!accounts.isEmpty()) {
            insert as user accounts;
        }
        return accounts;
    }

    /**
     * @description Counts Accounts whose Name starts with the given prefix.
     */
    public static Integer countAccountsByPrefix(String prefix) {
        if (String.isBlank(prefix)) {
            return 0;
        }
        String searchPattern = prefix.trim() + '%';
        return [SELECT COUNT() FROM Account WHERE Name LIKE :searchPattern WITH USER_MODE];
    }
}
