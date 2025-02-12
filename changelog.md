# Explanation for changes

### I am going to add the reason/insights for each of valuable changes pushed to the repo for solving this code assignment.

1.  Add specs to improve confidence for future changes.
    - As our existing solution is a complex one to understand and to do any modifications. So it's better to have spec coverage for the current implementation.
    - Also, having the specs for existing implementation will be helpful in refactoring and in finding any unknown issue introduce while adding any new feature.
2.  Abstract update item logic to a private method & create constant for magic strings.

3.  Add update_item_quality method and remove unnecessary condition check around update logic.

4.  Refactored the update_item method and try to use positive statement.

    - Also, update_item method has below problem.
      Assignment Branch Condition size for update_item is too high. [<1, 23, 20> 30.5/15](convention:Metrics/AbcSize) Cyclomatic complexity for update_item is too high. [11/6](convention:Metrics/CyclomaticComplexity) Method has too many lines. [20/10](convention:Metrics/MethodLength)

5.  Refactored code to move coherent code to the same place.

6.  Refactored code to move code related to item types like NORMAL, AGE BRIE, BACKSTAGE PASSESS and SULFURAS to a new service like class which does only one operation, which is update item. Also, I have used simple delegator instead of def_delegators becuase for def_delegators I had to write all delegated methods.

7.  Used lookup to fix if-else-if problem for finding the right updater service for updating the item.

8.  Finally add feature for Conjured items by adding a new updater service class.
