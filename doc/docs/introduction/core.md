---
sidebar_position: 2
---

# Core

The ASP consists of three components: **Atoms**, **Actions**, and **Selectors**.
In general, knowledge of these three is enough to master the pattern.

## Atom

The smallest part of a state. It is responsible for propagating changes to **Widgets** or functions but does not have the ability to change its own state.

```dart
final productsState = atom<List<Product>>(
    []
    key: 'productsState',
);
```

## Action

Responsible for changing the state of an **Atom**. This component can be instantiated in four ways, each representing the number of arguments it can receive:

- `atomAction`: Receives no arguments.
- `atomAction1`: Receives 1 argument.
- `atomAction2`: Receives 2 arguments.
- `atomAction3`: Receives 3 arguments.

```dart
final addProductAction = atomAction1<Product>(
    key: 'addProductAction',
    (set, newProduct) {
        final products = productsState.state;
        set(productsState, [...products, newProduct]);
    } 
);

// exec
addProductAction(Product(id: 1, name: 'Prod', price: 1));
```

## Selector

**Selectors** are responsible for deriving states from one or more **Atoms**.
Values assigned by the **get** property will compute a new state in the **Selector** when modified. **Selector** is also a type of **Atom**.

```dart
final totalPriceState = selector<String>(
    key: 'totalPriceState',
    (get) {
        final products = get(productsState);
        final value = products.fold(
            0.0,
            (value, product) => value + product.price,
        );
        return r'R$ ' + value.toStringAsFixed(2);
    }
);
```

## Rules

To effectively use this approach, consider these architectural limits:

1. All states must be an **Atom**.
2. An **Atom** can only be altered by an **Action**.
3. Use **atomSelector** to combine multiple **Atoms**.
4. Anything outside these rules is incorrect.

