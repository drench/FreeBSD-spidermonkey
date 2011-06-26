--- jslock.cpp.orig	2011-03-31 14:08:36.000000000 -0500
+++ jslock.cpp	2011-08-11 19:55:57.000000000 -0500
@@ -311,8 +311,10 @@
 
 #define GLOBAL_LOCK_INDEX(id)   (((uint32)(jsuword)(id)>>2) & global_locks_mask)
 
+#ifndef NSPR_LOCK
 static void
 js_Dequeue(JSThinLock *);
+#endif
 
 static PRLock **global_locks;
 static uint32 global_lock_count = 1;
