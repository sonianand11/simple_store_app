This is sample application to demonstrate Rails5 api feature.

**Install**

    git clone git@github.com:sonianand11/simple_store_app.git

    cd simple_store_app

    bundle install

**Database configuration**

    rake db:setup

**Run application**

    rails s

**CURLs to access application**

*Stores URLs* :

**index** : curl -X GET localhost:3000/api/v1/stores
**show** : curl -X GET localhost:3000/api/v1/stores/1
**create** : curl -X POST -d store[name]=new_store localhost:3000/api/v1/stores -u "user:user"
**update** : curl -X PUT -d store[name]=my_store1 localhost:3000/api/v1/stores/1 -u "user:user"
**destroy** : curl -X DELETE localhost:3000/api/v1/stores/1 -u "user:user"

*Products URLs:*

**index** : curl -X GET localhost:3000/api/v1/stores/1/products
**show** : curl -X GET localhost:3000/api/v1/stores/1/products/1
**update** : curl -X PUT -d product[name]=my_product localhost:3000/api/v1/stores/1/products/1 -u "user:user"
**create** : curl -X POST -d product[name]=new_product localhost:3000/api/v1/stores/1/products -u "user:user"
**destroy** : curl -X DELETE localhost:3000/api/v1/stores/1/products/1 -u "user:user"

*Users URLs:*

**index** : curl -X GET localhost:3000/api/v1/users -u "admin:admin"
**index** : curl -X GET localhost:3000/api/v1/users -u "user:user"
**show** : curl -X GET localhost:3000/api/v1/users/1  -u "user:user"
**update** : curl -X PUT -d user[name]=users1 localhost:3000/api/v1/users/1 -u "user:user"
**create** : curl -X POST -d user[name]=users2 localhost:3000/api/v1/users -u "user:user"
**destroy** : curl -X DELETE localhost:3000/api/v1/users/1 -u "user:user"


**Permissions :** 

- All can read Store, Product
- Admin user can manage everything in system
- Normal user can create, update, destroy own records like Store, Product