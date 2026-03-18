#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/ai/chat_test.go lib/ai/model/tokencount_test.go 2>/dev/null || true" EXIT
git checkout 2b15263e49da5625922581569834eec4838a9257 -- lib/ai/chat_test.go lib/ai/model/tokencount_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_batchReducer_Add/empty,TestChat_PromptTokens/tokenize_our_prompt,TestAsynchronousTokenCounter_TokenCount,TestChat_PromptTokens/empty,TestNodeEmbeddingGeneration,TestKNNRetriever_GetRelevant,Test_batchReducer_Add/many_elements,TestChat_PromptTokens/system_and_user_messages,TestAsynchronousTokenCounter_TokenCount/empty_count,TestAsynchronousTokenCounter_TokenCount/only_completion_start,TestKNNRetriever_Insert,TestChat_Complete,TestChat_Complete/command_completion,Test_batchReducer_Add/propagate_error,TestAsynchronousTokenCounter_Finished,TestAsynchronousTokenCounter_TokenCount/completion_start_and_end,Test_batchReducer_Add/one_element,TestAsynchronousTokenCounter_TokenCount/only_completion_add,TestChat_PromptTokens,TestChat_Complete/text_completion,TestChat_PromptTokens/only_system_message,Test_batchReducer_Add,TestKNNRetriever_Remove,TestSimpleRetriever_GetRelevant,TestMarshallUnmarshallEmbedding
