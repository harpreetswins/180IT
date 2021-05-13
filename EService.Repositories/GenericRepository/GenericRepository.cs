﻿using Admin.Data.Response;
using Dapper;
using EService.Domain.DomainModels.ExceptionHandler;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Threading.Tasks;

namespace Admin.Data.GenericRepository
{
    public class GenericRepository
    {
        private readonly IConfiguration _configuration;
        public GenericRepository(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        private IDbConnection CreateConnection()
        {
            string cn = _configuration["ConnectionStrings:DefaultConnection"];
            return new SqlConnection(cn);
        }
        /// <summary>
        /// Return the collection of T type
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sql"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        protected async Task<IEnumerable<T>> CollectionsAsync<T>(string sql, object parameters = null)
        {
            using (var connection = CreateConnection())
            {
                try
                {
                    var QueryResponse = await connection.QueryAsync<T>(sql: sql, param: parameters, commandType: CommandType.StoredProcedure);
                    return QueryResponse;
                }
                catch (Exception ex)
                {
                    throw new SqlExceptionHandler(ex.Message, sql,JsonConvert.SerializeObject(parameters));
                }
            }
        }
        protected async Task<IEnumerable<T>> Query<T>(string sql, object parameters = null)
        {
            using (var connection = CreateConnection())
            {
                try
                {
                    var QueryResponse = await connection.QueryAsync<T>(sql: sql, param: parameters, commandType: CommandType.StoredProcedure);
                    return QueryResponse;
                }
                catch (Exception ex)
                {
                    throw new SqlExceptionHandler(ex.Message, sql, JsonConvert.SerializeObject(parameters));
                }
            }
        }
        /// <summary>
        /// Return the single row
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sql"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        protected async Task<T> SingleAsync<T>(string sql, object parameters = null)
        {
            using (var connection = CreateConnection())
            {
                try
                {
                    var QueryResponse = await connection.QueryFirstAsync<T>(sql: sql, param: parameters, commandType: CommandType.StoredProcedure);
                    return QueryResponse;
                }
                catch (Exception ex)
                {
                    throw new SqlExceptionHandler(ex.Message, sql, JsonConvert.SerializeObject(parameters));
                }
            }
        }
        /// <summary>
        /// Used to perform insert, update, delete
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sql"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        protected async Task<T> CommandAsync<T>(string sql, object parameters = null)
        {
            using (var connection = CreateConnection())
            {
                try
                {
                    var QueryResponse = await connection.QueryFirstAsync<T>(sql: sql, param: parameters, commandType: CommandType.StoredProcedure);
                    return QueryResponse;
                }
                catch (Exception ex)
                {

                    throw new SqlExceptionHandler(ex.Message, sql, JsonConvert.SerializeObject(parameters));
                }
            }
        }
    }
}
