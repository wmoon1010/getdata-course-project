# CodeBook

## Source data
Human Activity Recognition Using Smartphones Dataset (UCI).
Accelerometer and gyroscope signals were recorded from a Samsung Galaxy S
smartphone worn on the waist by 30 volunteers while performing 6 activities.

## Tidy data set (`tidy_data.txt`)
- 180 rows = 30 subjects x 6 activities.
- 68 columns = 2 identifiers + 66 measurement variables.
- Each measurement value is the **average** of all the original observations
  for that subject and that activity.
- The original features are normalized and bounded within [-1, 1],
  so the values have no units.

## Identifiers
| Variable | Description |
|---|---|
| `subject` | Volunteer ID, integer from 1 to 30 |
| `activity` | WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING |

## Variable naming rules
| Part of the name | Meaning |
|---|---|
| `time` (prefix) | Time-domain signal |
| `frequency` (prefix) | Frequency-domain signal (FFT applied) |
| `Body` | Body motion component |
| `Gravity` | Gravity component |
| `Accelerometer` | Signal from the accelerometer |
| `Gyroscope` | Signal from the gyroscope |
| `Jerk` | Jerk signal derived from body motion |
| `Magnitude` | Magnitude of the 3-D signal (Euclidean norm) |
| `Mean` | Mean value |
| `Std` | Standard deviation |
| `X`, `Y`, `Z` | Axis of the signal (only for non-magnitude variables) |

## Measurement variables (66)
Time-domain, accelerometer:
- `timeBodyAccelerometerMeanX`, `timeBodyAccelerometerMeanY`, `timeBodyAccelerometerMeanZ`
- `timeBodyAccelerometerStdX`, `timeBodyAccelerometerStdY`, `timeBodyAccelerometerStdZ`
- `timeGravityAccelerometerMeanX`, `timeGravityAccelerometerMeanY`, `timeGravityAccelerometerMeanZ`
- `timeGravityAccelerometerStdX`, `timeGravityAccelerometerStdY`, `timeGravityAccelerometerStdZ`
- `timeBodyAccelerometerJerkMeanX`, `timeBodyAccelerometerJerkMeanY`, `timeBodyAccelerometerJerkMeanZ`
- `timeBodyAccelerometerJerkStdX`, `timeBodyAccelerometerJerkStdY`, `timeBodyAccelerometerJerkStdZ`

Time-domain, gyroscope:
- `timeBodyGyroscopeMeanX`, `timeBodyGyroscopeMeanY`, `timeBodyGyroscopeMeanZ`
- `timeBodyGyroscopeStdX`, `timeBodyGyroscopeStdY`, `timeBodyGyroscopeStdZ`
- `timeBodyGyroscopeJerkMeanX`, `timeBodyGyroscopeJerkMeanY`, `timeBodyGyroscopeJerkMeanZ`
- `timeBodyGyroscopeJerkStdX`, `timeBodyGyroscopeJerkStdY`, `timeBodyGyroscopeJerkStdZ`

Time-domain, magnitudes:
- `timeBodyAccelerometerMagnitudeMean`, `timeBodyAccelerometerMagnitudeStd`
- `timeGravityAccelerometerMagnitudeMean`, `timeGravityAccelerometerMagnitudeStd`
- `timeBodyAccelerometerJerkMagnitudeMean`, `timeBodyAccelerometerJerkMagnitudeStd`
- `timeBodyGyroscopeMagnitudeMean`, `timeBodyGyroscopeMagnitudeStd`
- `timeBodyGyroscopeJerkMagnitudeMean`, `timeBodyGyroscopeJerkMagnitudeStd`

Frequency-domain, accelerometer:
- `frequencyBodyAccelerometerMeanX`, `frequencyBodyAccelerometerMeanY`, `frequencyBodyAccelerometerMeanZ`
- `frequencyBodyAccelerometerStdX`, `frequencyBodyAccelerometerStdY`, `frequencyBodyAccelerometerStdZ`
- `frequencyBodyAccelerometerJerkMeanX`, `frequencyBodyAccelerometerJerkMeanY`, `frequencyBodyAccelerometerJerkMeanZ`
- `frequencyBodyAccelerometerJerkStdX`, `frequencyBodyAccelerometerJerkStdY`, `frequencyBodyAccelerometerJerkStdZ`

Frequency-domain, gyroscope:
- `frequencyBodyGyroscopeMeanX`, `frequencyBodyGyroscopeMeanY`, `frequencyBodyGyroscopeMeanZ`
- `frequencyBodyGyroscopeStdX`, `frequencyBodyGyroscopeStdY`, `frequencyBodyGyroscopeStdZ`

Frequency-domain, magnitudes:
- `frequencyBodyAccelerometerMagnitudeMean`, `frequencyBodyAccelerometerMagnitudeStd`
- `frequencyBodyAccelerometerJerkMagnitudeMean`, `frequencyBodyAccelerometerJerkMagnitudeStd`
- `frequencyBodyGyroscopeMagnitudeMean`, `frequencyBodyGyroscopeMagnitudeStd`
- `frequencyBodyGyroscopeJerkMagnitudeMean`, `frequencyBodyGyroscopeJerkMagnitudeStd`

## Transformations performed by `run_analysis.R`
1. Merged the training set (7352 rows) and the test set (2947 rows)
   into one data set of 10299 rows, with the subject and activity columns.
2. Kept only the columns whose original name contains `mean()` or `std()`
   (66 columns). Columns such as `meanFreq()` and `angle(...)` were excluded
   because they are not direct means or standard deviations of a measurement.
3. Replaced the activity IDs (1-6) with the names in `activity_labels.txt`.
4. Made variable names descriptive:
   removed `()` and `-`; `t` -> `time`; `f` -> `frequency`;
   `Acc` -> `Accelerometer`; `Gyro` -> `Gyroscope`; `Mag` -> `Magnitude`;
   `-mean` -> `Mean`; `-std` -> `Std`; fixed the duplicated `BodyBody` -> `Body`.
5. Grouped by subject and activity and computed the mean of each variable,
   giving the final tidy data set of 180 rows.
