CC      = gcc
CFLAGS  = -Wall -Wextra -g -DTEST_BUILDTREE -DTEST_PRINTPATH
TARGET  = hw13
SRCS    = main.c tree.c
 
TESTDIR = testcases
EXPDIR  = expected
OUTDIR  = outputs
 
TESTS   = 1 2 3 4 5 6
 
.PHONY: all clean test $(addprefix test,$(TESTS))
 
all: $(TARGET)
 
$(TARGET): $(SRCS) tree.h
	$(CC) $(CFLAGS) -o $(TARGET) $(SRCS)
 
# Run all tests
test: $(TARGET) | $(OUTDIR)
	@passed=0; failed=0; \
	for i in $(TESTS); do \
		./$(TARGET) $(TESTDIR)/test$${i}in $(TESTDIR)/test$${i}post > $(OUTDIR)/output$${i} 2>&1; \
		if diff -q $(OUTDIR)/output$${i} $(EXPDIR)/expected$${i} > /dev/null 2>&1; then \
			echo "Test $${i}: PASS"; \
			passed=$$((passed+1)); \
		else \
			echo "Test $${i}: FAIL"; \
			echo "  --- expected ---"; \
			cat $(EXPDIR)/expected$${i}; \
			echo "  --- got ---"; \
			cat $(OUTDIR)/output$${i}; \
			failed=$$((failed+1)); \
		fi; \
	done; \
	echo ""; \
	echo "Results: $$passed passed, $$failed failed"
 
# Run a single test: make test1, make test2, etc.
$(addprefix test,$(TESTS)): $(TARGET) | $(OUTDIR)
	$(eval N := $(subst test,,$@))
	@./$(TARGET) $(TESTDIR)/test$(N)in $(TESTDIR)/test$(N)post > $(OUTDIR)/output$(N) 2>&1; \
	if diff -q $(OUTDIR)/output$(N) $(EXPDIR)/expected$(N) > /dev/null 2>&1; then \
		echo "Test $(N): PASS"; \
	else \
		echo "Test $(N): FAIL"; \
		echo "  --- expected ---"; \
		cat $(EXPDIR)/expected$(N); \
		echo "  --- got ---"; \
		cat $(OUTDIR)/output$(N); \
	fi
 
# Valgrind check on all tests
valgrind: $(TARGET) | $(OUTDIR)
	@for i in $(TESTS); do \
		echo "=== Valgrind Test $${i} ==="; \
		valgrind --leak-check=full --error-exitcode=1 \
			./$(TARGET) $(TESTDIR)/test$${i}in $(TESTDIR)/test$${i}post \
			> $(OUTDIR)/valgrind$${i}.out 2>&1; \
		if [ $$? -eq 0 ]; then \
			echo "  No leaks detected"; \
		else \
			echo "  LEAK or ERROR detected — see $(OUTDIR)/valgrind$${i}.out"; \
		fi; \
	done
 
$(OUTDIR):
	mkdir -p $(OUTDIR)
 
clean:
	rm -f $(TARGET) $(OUTDIR)/output* $(OUTDIR)/valgrind*