{% docs tcurr %}

Contains the absolute exchange rates from one currency to another in a specific timeframe

| Attribute | Explanation                                                                                                      |
|-----------|-----------------------------------------------------------------------------------------------------------------|
| MANDT     | SAP Mandant                                                                                                     |
| KURST     | Exchange Rate Type. Can differ from Customer to Customer. The standard script uses KURST = 'M', which is defined as the Average exchange rate type |
| FCURR     | FROM Currency - The initial currency you want to convert from                                                   |
| TCURR     | TO Currency - The output currency you want to convert to                                                        |
| GDATU     | The date, on which the exchange rate is valid                                                                    |
| UKURS     | The absolute exchange rate on the specific date (GDATU); The UKURS values are stored in the numerical format XXXX,XXXXX, so the exchange rates can have values from 0,00001 to 9999,99999 |
| FFACT*    | Ratio for the "From" Currency Units                                                                              |
| TFACT*    | Ratio for the "To" Currency Units                                                                                |

{% enddocs %}