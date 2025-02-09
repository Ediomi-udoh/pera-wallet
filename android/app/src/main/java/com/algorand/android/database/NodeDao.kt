/*
 * Copyright 2022 Pera Wallet, LDA
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License
 */

package com.algorand.android.database

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Transaction
import androidx.room.Update
import com.algorand.android.models.Node
import kotlinx.coroutines.flow.Flow

@Dao
interface NodeDao {
    @Query("SELECT * FROM node WHERE is_added_default")
    fun getAllNode(): List<Node>

    @Query("SELECT * FROM node WHERE is_added_default")
    fun getAllNodeAsFlow(): Flow<List<Node>>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertNodeList(nodeList: List<Node>)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertNode(node: Node)

    @Update(onConflict = OnConflictStrategy.REPLACE)
    suspend fun updateNode(node: Node): Int

    @Update(onConflict = OnConflictStrategy.REPLACE)
    suspend fun updateNodes(nodeList: List<Node>)

    @Delete
    suspend fun removeNode(node: Node)

    @Query("DELETE FROM node")
    suspend fun deleteAll()

    @Transaction
    suspend fun deleteAllThenInsertNodes(nodeList: List<Node>) {
        deleteAll()
        insertNodeList(nodeList)
    }
}
