package com.example.demo2.utils;

import com.example.demo2.entities.RegistrationRecord;

import java.util.Comparator;
import java.util.List;

public class RegistrationSorter {

    public void sortByTime(List<RegistrationRecord> records, boolean ascending) {
        records.sort((r1, r2) -> {
            if (ascending) {
                return r1.getRegistrationTime().compareTo(r2.getRegistrationTime());
            } else {
                return r2.getRegistrationTime().compareTo(r1.getRegistrationTime());
            }
        });
    }

    public void sortByUsername(List<RegistrationRecord> records, boolean ascending) {
        records.sort((r1, r2) -> {
            if (ascending) {
                return r1.getUsername().compareToIgnoreCase(r2.getUsername());
            } else {
                return r2.getUsername().compareToIgnoreCase(r1.getUsername());
            }
        });
    }
}
