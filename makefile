test_gcd:
	$(MAKE) -C ./Programs/GCD\ Program test

test_sort:
	$(MAKE) -C ./Programs/Bubble\ Sort\ Program test

clean: 
	$(MAKE) -C ./Programs/GCD\ Program clean
	$(MAKE) -C ./Programs/Bubble\ Sort\ Program clean