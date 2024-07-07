/*
*  Copyright (c) 2005-2011, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
*
*  WSO2 Inc. licenses this file to you under the Apache License,
*  Version 2.0 (the "License"); you may not use this file except
*  in compliance with the License.
*  You may obtain a copy of the License at
*
*    http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing,
* software distributed under the License is distributed on an
* "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
* KIND, either express or implied.  See the License for the
* specific language governing permissions and limitations
* under the License.
*/
package org.wso2.carbon.core.clustering.hazelcast;

import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.cluster.Member;
import org.apache.axis2.clustering.MembershipScheme;

/**
 * MembershipScheme which adds some methods for the Hazelcast based clustering implementation
 */
public interface HazelcastMembershipScheme extends MembershipScheme {

    void setPrimaryHazelcastInstance(HazelcastInstance primaryHazelcastInstance);

    void setLocalMember(Member localMember);

    void setCarbonCluster(HazelcastCarbonClusterImpl hazelcastCarbonCluster);
}
