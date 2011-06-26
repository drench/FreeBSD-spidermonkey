--- jsopcode.cpp.orig	2011-08-11 19:58:41.000000000 -0500
+++ jsopcode.cpp	2011-08-11 19:59:16.000000000 -0500
@@ -498,7 +498,7 @@
         pc2 += jmplen;
         npairs = GET_UINT16(pc2);
         pc2 += UINT16_LEN;
-        fprintf(fp, " offset %d npairs %u", (intN) off, (uintN) npairs);
+        fprintf(fp, " offset %td npairs %u", (intN) off, (uintN) npairs);
         while (npairs) {
             uint16 constIndex = GET_INDEX(pc2);
             pc2 += INDEX_LEN;
