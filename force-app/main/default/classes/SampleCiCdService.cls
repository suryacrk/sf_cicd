/**
 * @description Small service class used to demonstrate CI/CD code coverage 09-29 08:00 PM.
 */
public with sharing class SampleCiCdService {

    public static Integer add(Integer a, Integer b) {
        if (a == null || b == null) {
            return 0;
        }
        return a + b;
    }

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

    public static String formatGreeting(String name) {
        if (String.isBlank(name)) {
            return 'Hello, Guest!';
        }
        return 'Hello, ' + name.trim() + '!';
    }

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

    public static Integer countAccountsByPrefix(String prefix) {
        if (String.isBlank(prefix)) {
            return 0;
        }
        String searchPattern = prefix.trim() + '%';
        return [SELECT COUNT() FROM Account WHERE Name LIKE :searchPattern WITH USER_MODE];
    }
}
