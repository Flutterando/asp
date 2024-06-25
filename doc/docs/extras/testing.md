---
sidebar_position: 4
---

# Testing

**Atoms** has two methods created to assist in unit testing, `Atom.next()` and `Atom.buffer()`. <br></br>
`Atom.next()` returns a **Future** that waits for the next state change while `Atom.buffer()` can wait for a number of next states.

```dart
test('Atom next', () async {
    final bmiState = selector<double>(0.0);

    // start listen changes
    expect(bmiState.next(), completion(20.74));

    final calcBMI = atomAction2<double, double>(
        (set, weight, height) {
          final result = weight / (height * height);
          set(bmiState, result);
        },
    );

    calcBMI(65, 1.77)
});
```